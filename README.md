
# Tugas 7 Praktikum Pemrograman Mobile
## Identitas Diri
Nama: Adeyunita Rachmadhani

NIM: H1D023057

Shift Baru: E

Shift KRS: F

# Screenshot Aplikasi
<img src="https://github.com/user-attachments/assets/1167bc2e-5479-4564-803d-7a85a1d8c10e" width="300"> <br> 
<img src="https://github.com/user-attachments/assets/1e47d6e8-027b-474b-87af-68488451f513" width="300"> <br> 
<img src="https://github.com/user-attachments/assets/26259945-5ec6-466f-8a09-2ef02f7d4619" width="300"> <br> 
<img src="https://github.com/user-attachments/assets/f21227e7-055d-4d26-a42c-1f6ecf395123" width="300"> <br> 
<img src="https://github.com/user-attachments/assets/9c766e2c-ab85-48d5-a963-d4f2b73b53e7" width="300"> <br> 
<img src="https://github.com/user-attachments/assets/6bddd118-c194-487a-a961-2a1080d944b5" width="300"> <br>


# Penjelasan
### 1. Login
Ketika aplikasi dibuka, pengguna langsung masuk ke LoginScreen. Pengguna memasukkan nickname dan password yang dibaca melalui TextField controller. Ketika tombol login ditekan, fungsi _handleLogin() menjalankan pengecekan input kosong lalu mencocokkan dengan nickname dan password yang sudah tertanam di kode. Jika salah, aplikasi menampilkan pesan error. Jika benar, username disimpan ke SharedPreferences dan aplikasi berpindah ke Dashboard melalui Navigator.

### 2. Dashboard
Saat DashboardScreen ditampilkan, fungsi initState() memanggil _loadUserData() untuk mengambil username dan daftar fokus yang tersimpan di SharedPreferences. Data tersebut ditampilkan pada sambutan dan ListView. Dengan ini, dashboard selalu menampilkan data terbaru yang sesuai dengan penyimpanan lokal.

### 3. Menambah Focus Item
Ketika pengguna menambahkan fokus baru dan menekan tombol Add, fungsi _addFocus() memasukkan teks baru ke _focusList, lalu menyimpannya kembali ke SharedPreferences menggunakan setStringList(). Setelah itu, UI diperbarui dengan setState() sehingga item langsung muncul di layar dan tetap tersimpan walaupun aplikasi ditutup.

### 4. Menghapus Focus Item
Jika pengguna melakukan swipe pada salah satu item, fungsi _removeFocus() dijalankan untuk menghapus item berdasarkan indeksnya. Daftar yang telah diperbarui kembali disimpan ke SharedPreferences. Proses ini memastikan penghapusan fokus konsisten antara tampilan aplikasi dan data yang tersimpan.

### 5. Clear All
Ketika tombol delete di AppBar ditekan, fungsi _clearAll() menghapus seluruh daftar fokus dari SharedPreferences. Setelah itu, _focusList dikosongkan melalui setState() sehingga tampilan dashboard langsung menunjukkan bahwa seluruh data fokus telah terhapus.

### 6. Navigasi Drawer
Drawer pada aplikasi menyediakan navigasi menuju halaman Dashboard, Profile, About, serta Logout. Perpindahan halaman dilakukan menggunakan Navigator.pushReplacementNamed() sehingga halaman sebelumnya tidak tersimpan dalam stack. Dengan route name (/dashboard, /profile, /about), alur navigasi menjadi konsisten dan mudah dipelihara.

### 7. Logout
Pada versi logout yang kamu gunakan, fungsi logout menjalankan prefs.clear() yang menghapus seluruh data di SharedPreferences, termasuk username dan daftar fokus. Setelah itu aplikasi kembali ke LoginScreen menggunakan Navigator.pushNamedAndRemoveUntil().



