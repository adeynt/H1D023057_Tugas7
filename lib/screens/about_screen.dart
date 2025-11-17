import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      drawer: AppDrawer(username: _username),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            Text(
              'About App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Personal app to help you stay aware of your day. '
              'Instead of chasing big goals only, it reminds you to start with '
              'one small daily intention.',
            ),
            SizedBox(height: 12),
            Text(
              'In this demo version you can:'
              '\n• Log in with a simple nickname and password'
              '\n• Write your daily intention on the dashboard'
              '\n• Edit your nickname on the profile page'
              '\n• Navigate using a side menu (drawer)',
            ),
            SizedBox(height: 12),
            Text(
              'The idea is simple: better days are built from tiny, consistent steps. ',
            ),
          ],
        ),
      ),
    );
  }
}
