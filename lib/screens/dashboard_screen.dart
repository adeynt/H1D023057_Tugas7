import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _username;
  final TextEditingController _focusController = TextEditingController();
  List<String> _focusList = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('username');
    final storedList = prefs.getStringList('focus_items') ?? [];

    setState(() {
      _username = name;
      _focusList = storedList;
    });
  }

  Future<void> _addFocus() async {
    final text = _focusController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Write something first')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final updatedList = [..._focusList, text];

    await prefs.setStringList('focus_items', updatedList);

    setState(() {
      _focusList = updatedList;
      _focusController.clear();
    });
  }

  Future<void> _removeFocus(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final updatedList = List<String>.from(_focusList)..removeAt(index);

    await prefs.setStringList('focus_items', updatedList);

    setState(() {
      _focusList = updatedList;
    });
  }

  Future<void> _clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('focus_items');

    setState(() {
      _focusList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final greetingName = _username ?? 'Friend';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          if (_focusList.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Clear all focus items',
              onPressed: _clearAll,
            ),
        ],
      ),
      drawer: AppDrawer(username: _username),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $greetingName',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'List a few things you want to focus on today.',
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _focusController,
                    decoration: const InputDecoration(
                      labelText: 'Add a focus item',
                      hintText: 'e.g. “Finish assignment”, “Drink more water”',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addFocus,
                  child: const Text('Add'),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Today’s focus list',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: _focusList.isEmpty
                  ? const Center(
                      child: Text(
                        'No focus items yet.\nStart by adding one or two ✨',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _focusList.length,
                      itemBuilder: (context, index) {
                        final item = _focusList[index];
                        return Dismissible(
                          key: ValueKey('$item-$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            color: Colors.redAccent,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => _removeFocus(index),
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(item),
                              subtitle: const Text('Today’s focus'),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
