
## Identitas Project

| Keterangan | Informasi |
| --- | --- |
| Nama aplikasi | KIYUTBIN |
| Nama kelompok | Kelompok KIYUTBIN |
| Platform | Android (Flutter) |

### Anggota Kelompok


| Nama | NIM |
|------|------|
| Ni Putu Kartika Wirastari | 240040135 |
| Kadek Yuni Dwiyantini Savitri | 240040138 |
| Ni Nyoman Putri Kirana | 240040140 |


## Deskripsi

KIYUTBIN adalah aplikasi mobile berbasis Flutter untuk mendukung edukasi dan partisipasi masyarakat dalam pengelolaan sampah. Aplikasi ini menyediakan informasi lingkungan, artikel edukatif, agenda kegiatan, serta fitur pendukung agar pengguna lebih mudah menerapkan pengelolaan sampah yang bertanggung jawab.


## Permasalahan

Permasalahan yang diangkat dalam pengembangan KIYUTBIN meliputi:

- Rendahnya literasi masyarakat tentang pemilahan sampah dan cara pengelolaannya.
- Kebiasaan membuang atau menangani sampah secara tidak tepat yang berisiko mencemari tanah, air, dan udara.
- Sulitnya memperoleh informasi terpusat mengenai artikel edukasi, kegiatan lingkungan, dan fasilitas pengelolaan sampah.
- Masih terbatasnya ruang digital bagi masyarakat untuk berbagi informasi dan membangun komunitas peduli lingkungan.

## Solusi

## Solusi yang Ditawarkan

KIYUTBIN merupakan aplikasi mobile yang dirancang untuk meningkatkan kepedulian masyarakat terhadap pengelolaan sampah melalui penyediaan informasi, edukasi, dan media berbagi dalam satu platform. Aplikasi ini menghadirkan beberapa fitur utama yang saling terintegrasi untuk membantu pengguna memperoleh informasi mengenai lingkungan dengan lebih mudah. Melalui fitur **Blog**, pengguna dapat membaca maupun membagikan artikel edukasi terkait pengelolaan sampah dan pelestarian lingkungan. Fitur **Post** menyediakan informasi mengenai penjualan barang bekas yang masih memiliki nilai guna sehingga dapat dimanfaatkan kembali oleh masyarakat. Selain itu, fitur **Event** memberikan informasi mengenai kegiatan atau acara bertema lingkungan yang dapat diikuti oleh pengguna.

KIYUTBIN juga menyediakan fitur **Location** yang menampilkan lokasi tempat pembuangan atau pengelolaan sampah melalui peta berbasis OpenStreetMap sehingga membantu pengguna menemukan lokasi yang tersedia. Pada fitur **Scanner**, pengguna dapat mengakses kamera, flash, dan galeri sebagai langkah awal untuk mendukung proses pemindaian sampah pada pengembangan berikutnya. Untuk meningkatkan pengalaman pengguna, aplikasi dilengkapi dengan fitur **Registrasi**, **Login**, dan **Profile** sehingga pengguna dapat mengelola akun serta mengelola artikel yang telah dibuat. Seluruh fitur tersebut dirancang dengan antarmuka yang sederhana agar mudah digunakan oleh berbagai kalangan masyarakat. Dengan demikian, aplikasi ini diharapkan dapat menjadi solusi digital yang membantu masyarakat menemukan lokasi tempat pembuangan sampah, memahami cara pengelolaan sampah yang tepat, serta mendorong partisipasi aktif dalam mewujudkan lingkungan yang bersih, sehat, dan berkelanjutan.

## Tujuan

- Menjadi media digital untuk mendukung edukasi pengelolaan sampah bagi masyarakat.
- Memudahkan akses terhadap artikel, kegiatan, dan informasi pengelolaan sampah.
- Mendorong partisipasi masyarakat dalam kegiatan pelestarian lingkungan dan penerapan prinsip 3R (_Reduce, Reuse, Recycle_).

## Fitur

| **Fitur**                | **Deskripsi**                                                                                                                                              |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Registrasi dan Login** | Registrasi akun baru, login, logout, dan autentikasi pengguna menggunakan Supabase Authentication.                                                         |
| **Home**                 | Menampilkan halaman utama aplikasi yang menyediakan akses ke seluruh fitur utama KIYUTBIN.                                                                 |
| **Profil Pengguna**      | Melihat dan memperbarui informasi profil pengguna seperti nama, nomor telepon, foto profil, serta menampilkan daftar blog yang telah dibuat oleh pengguna. |
| **Blog**                 | Menampilkan artikel edukasi lingkungan, melihat detail artikel, serta mengelola artikel melalui fitur tambah, ubah, dan hapus (CRUD).                      |
| **Post**                 | Menampilkan daftar informasi penjualan sampah serta melihat detail informasi dari setiap postingan.                                                        |
| **Event**                | Menampilkan daftar kegiatan atau acara yang berkaitan dengan lingkungan beserta informasi setiap kegiatan.                                                 |
| **Scanner**        | Menampilkan pratinjau kamera, mengaktifkan atau menonaktifkan flash, serta memilih gambar dari galeri perangkat untuk proses pemindaian.                   |
| **Location**             | Menampilkan lokasi tempat pembuangan sam                                                                                                                   |


## Teknologi Yang Digunakan

- Flutter
- Supabase


## Cara Instalasi

### Prasyarat

- Flutter SDK yang kompatibel dengan Dart `^3.11.1`
- Android Studio atau perangkat Android yang telah mengaktifkan USB debugging
- Proyek Supabase yang telah dikonfigurasi beserta tabel dan bucket yang digunakan aplikasi

### Langkah menjalankan aplikasi

1. Kloning repositori ini lalu masuk ke folder proyek.

   ```bash
   git clone <https://github.com/Kirana0219/PPB2026_Kelompok02_Kiyutbin.git>
   ```

2. Instal dependensi Flutter.

   ```bash
   flutter pub get
   ```

3. Buat berkas `.env` pada direktori utama proyek. Isi dengan kredensial publishable dari proyek Supabase Anda.

   ```env
   SUPABASE_URL=https://<project-ref>.supabase.co
   SUPABASE_PUBLISHABLE_KEY=<supabase-publishable-key>
   ```
4. Dapat menginstall dan menggunakan APK dibawah ini:
   ``` link
   https://stmikstikombali-my.sharepoint.com/:f:/g/personal/240040140_stikom-bali_ac_id/IgB8dMYhNR0RTYvmy6WbX10lAULgtWMSSuk-eQfao5Tr3pQ?e=EZ4reT
   ```
   Ketika stuck pada halaman login bisa close aplikasi dan membukanya kembali. Atau masuk menggunakan putri@gmail.com (pass: putrik02)
### Kontribusi Anggota 

| **NIM**       | **Anggota**                  | **Kontribusi**                                                                           |
| ------------- | ---------------------------- | ---------------------------------------------------------------------------------------- |
| **240040140** | Kirana (Kirana0219)          | Membuat database, mengembangkan fitur Blog, Profile, Notifikasi, dan Waste Scanner.      |
| **240040135** | Putu Kartika (Putu-Kartika)  | Mengembangkan fitur Home, Post, dan Location.                                            |
| **240040138** | Yuni Dwiyantini (Yuni18-git) | Mendesain antarmuka aplikasi (UI), membuat Splash Screen, dan mengembangkan fitur Event. |

## Struktur Proyek

KIYUTBIN menggunakan **feature-based architecture**. Artinya, kode dikelompokkan berdasarkan fitur atau domain aplikasi, bukan hanya berdasarkan jenis file. Setiap fitur dapat memiliki _screen_, _service_, _model_, dan _widget_ sendiri sehingga lebih mudah dikembangkan dan dipelihara.

```text
KIYUTBIN_MOBILE
│
├── android/
├── assets/
├── lib/
│   │
│   ├── core/
│   │   ├── config/
│   │   ├── constants/
│   │   ├── layout/
│   │   ├── routes/
│   │   ├── theme/
│   │   └── utils/
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── models/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── blog/
│   │   │   ├── models/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── events/
│   │   │   ├── models/
│   │   │   ├── screens/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── home/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── location/
│   │   │   └── screen/
│   │   │
│   │   ├── notification/
│   │   │   ├── models/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── post/
│   │   │   ├── model/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   ├── qr_scanner/
│   │   │   ├── screen/
│   │   │   ├── services/
│   │   │   └── widgets/
│   │   │
│   │   └── splash/
│   │       └── screen/
│   │
│   └── main.dart
│
├── supabase/
│   └── migrations/
│
└── README.md
```
