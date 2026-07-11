# KIYUTBIN

KIYUTBIN adalah aplikasi mobile berbasis Flutter untuk mendukung edukasi dan partisipasi masyarakat dalam pengelolaan sampah. Aplikasi ini menyediakan informasi lingkungan, artikel edukatif, agenda kegiatan, serta fitur pendukung agar pengguna lebih mudah menerapkan pengelolaan sampah yang bertanggung jawab.

## Identitas Project

| Keterangan | Informasi |
| --- | --- |
| Nama aplikasi | KIYUTBIN |
| Nama kelompok | Kelompok KIYUTBIN |
| Platform | Android (Flutter) |

### Anggota Kelompok

| Nama | Peran utama |
| --- | --- |
| Kirana | Autentikasi, profil, notifikasi, integrasi aplikasi |
| Putu Kartika | Fitur blog dan pengalaman pengguna blog |
| Yuni Dwiyantini | Splash screen, event, navigasi, dan aset aplikasi |

> Tambahkan NIM atau kelas masing-masing anggota pada tabel ini bila diperlukan untuk pengumpulan tugas.

## Deskripsi

Sampah masih menjadi persoalan lingkungan yang berdampak pada kebersihan, kesehatan, kualitas ekosistem, dan keberlanjutan kehidupan masyarakat. Peningkatan volume sampah, rendahnya kebiasaan pemilahan dari sumber, keterbatasan informasi fasilitas pengelolaan, serta rendahnya partisipasi dalam kegiatan lingkungan menjadi tantangan yang perlu ditangani bersama.

KIYUTBIN dikembangkan sebagai media digital yang mudah diakses untuk membantu masyarakat memperoleh edukasi pengelolaan sampah, informasi kegiatan lingkungan, dan ruang berbagi konten. Aplikasi menggunakan Supabase untuk autentikasi, basis data, dan penyimpanan berkas.

## Permasalahan

Permasalahan yang diangkat dalam pengembangan KIYUTBIN meliputi:

- Rendahnya literasi masyarakat tentang pemilahan sampah dan cara pengelolaannya.
- Kebiasaan membuang atau menangani sampah secara tidak tepat yang berisiko mencemari tanah, air, dan udara.
- Sulitnya memperoleh informasi terpusat mengenai artikel edukasi, kegiatan lingkungan, dan fasilitas pengelolaan sampah.
- Masih terbatasnya ruang digital bagi masyarakat untuk berbagi informasi dan membangun komunitas peduli lingkungan.

## Solusi

KIYUTBIN menyatukan edukasi, informasi kegiatan, dan interaksi komunitas dalam satu aplikasi mobile. Pengguna dapat membuat akun, mengelola profil, mencari dan menulis artikel, melihat agenda kegiatan, serta menerima notifikasi. Dalam ruang lingkup pengembangan, aplikasi juga dirancang untuk membantu pengguna menemukan lokasi fasilitas pengelolaan sampah dan mengenali jenis sampah melalui pemindaian kamera.

Solusi ini mendukung tujuan pembangunan berkelanjutan (SDGs), khususnya SDG 4 (Pendidikan Berkualitas), SDG 11 (Kota dan Permukiman Berkelanjutan), dan SDG 12 (Konsumsi dan Produksi yang Bertanggung Jawab).

## Tujuan

- Menjadi media digital untuk mendukung edukasi pengelolaan sampah bagi masyarakat.
- Memudahkan akses terhadap artikel, kegiatan, dan informasi pengelolaan sampah.
- Mendorong partisipasi masyarakat dalam kegiatan pelestarian lingkungan dan penerapan prinsip 3R (_Reduce, Reuse, Recycle_).

## Fitur

| Fitur | Deskripsi | Status pada kode saat ini |
| --- | --- | --- |
| Registrasi dan login | Pendaftaran, masuk, keluar, dan pemulihan kata sandi melalui Supabase Authentication. | Tersedia |
| Profil pengguna | Melihat dan memperbarui nama, email, nomor telepon, serta foto profil. | Tersedia |
| Blog edukasi | Daftar artikel, artikel tren, detail, pencarian, kategori, dan _pull-to-refresh_. | Tersedia |
| Blog pribadi | Membuat, mengubah, dan menghapus artikel beserta gambar sampul. | Tersedia |
| Event | Kalender serta informasi kegiatan terdaftar, hari ini, dan kegiatan lainnya. | Tersedia (data tampilan) |
| Notifikasi | Melihat, menandai sudah dibaca, menghapus satu, atau menghapus semua notifikasi. | Tersedia |
| Waste Scanner | Pratinjau kamera, flash, ambil gambar, dan pilih gambar dari galeri. | Tersedia sebagai kamera; klasifikasi sampah belum diimplementasikan |
| Location | Peta lokasi tempat pembuangan sampah terdekat berbasis OpenStreetMap. | Direncanakan; belum ditemukan implementasinya pada kode |
| Post komunitas | Wadah berbagi informasi, tips, atau barang yang masih layak digunakan. | Modul awal tersedia; belum terhubung ke navigasi utama |

## Teknologi

- [Flutter](https://flutter.dev/) dan Dart
- [Supabase](https://supabase.com/) - Authentication, PostgreSQL Database, dan Storage
- `supabase_flutter` dan `flutter_dotenv`
- `camera`, `image_picker`, dan `permission_handler`
- `provider`, `google_fonts`, `flutter_svg`, `iconsax_flutter`, dan `intl`

## Cara Instalasi

### Prasyarat

- Flutter SDK yang kompatibel dengan Dart `^3.11.1`
- Android Studio atau perangkat Android yang telah mengaktifkan USB debugging
- Proyek Supabase yang telah dikonfigurasi beserta tabel dan bucket yang digunakan aplikasi

### Langkah menjalankan aplikasi

1. Kloning repositori ini lalu masuk ke folder proyek.

   ```bash
   git clone <url-repositori>
   cd kiyutbin_mobile
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

4. Terapkan migrasi pada folder `supabase/migrations/` ke proyek Supabase yang digunakan, termasuk konfigurasi sinkronisasi profil dan bucket `profile-photos`.

5. Pastikan izin kamera dan galeri diizinkan pada perangkat, lalu jalankan aplikasi.

   ```bash
   flutter run
   ```

## Pembagian Tugas

| Anggota | Kontribusi |
| --- | --- |
| Kirana |. |
| Putu Kartika | . |
| Yuni Dwiyantini | . |

## Struktur Proyek

KIYUTBIN menggunakan **feature-based architecture**. Artinya, kode dikelompokkan berdasarkan fitur atau domain aplikasi, bukan hanya berdasarkan jenis file. Setiap fitur dapat memiliki _screen_, _service_, _model_, dan _widget_ sendiri sehingga lebih mudah dikembangkan dan dipelihara.

```text
lib/
|-- core/
|   |-- config/            # Konfigurasi environment dan koneksi database
|   |-- constants/         # Konstanta aplikasi
|   |-- layout/widgets/    # Komponen layout bersama, seperti header dan bottom navigation
|   |-- routes/            # Konfigurasi rute aplikasi
|   |-- theme/             # Warna, tema, dan gaya teks
|   `-- utils/             # Utilitas dan validasi
|
|-- features/
|   |-- auth/              # Autentikasi dan profil pengguna
|   |-- blog/              # Artikel edukasi dan manajemen blog pribadi
|   |-- events/            # Informasi dan tampilan kegiatan lingkungan
|   |-- home/              # Halaman utama
|   |-- notification/      # Notifikasi pengguna
|   |-- post/              # Modul posting komunitas
|   |-- qr_scanner/        # Kamera dan antarmuka pemindaian
|   `-- splash/            # Splash screen dan auth gate
|
`-- main.dart              # Titik awal aplikasi

assets/
|-- icons/                 # Ikon aplikasi
`-- images/                # Gambar dan aset merek

supabase/
`-- migrations/            # Migrasi database dan storage Supabase

test/                      # Pengujian widget
android/                   # Konfigurasi platform Android
```
