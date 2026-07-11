import '../model/post_model.dart';

class PostService {
  const PostService._();

  static List<PostModel> get posts => [
    PostModel(
      id: "1",
      title: "Jaket Denim Levi's",
      category: "Fashion",
      description:
          "Jaket denim klasik dari Levi's dengan bahan yang tebal dan nyaman dipakai. Masih sangat bagus, jarang dipakai karena ukurannya terlalu besar untuk pemiliknya. Cocok untuk pria maupun wanita dengan gaya casual atau streetwear. Kondisi jahitan masih rapi, tidak ada sobekan atau noda membandel. Kancing dan resleting berfungsi dengan sempurna. Warna biru denim yang timeless dan mudah dipadupadankan dengan berbagai outfit. Harga masih bisa nego! Yuk, langsung chat saya via WhatsApp di 081234567890 untuk info lebih lanjut atau tawar-menawar. Bisa kirim foto detail tambahan juga kalau mau.",
      imageUrl: "assets/images/thrift1.jpeg",
      seller: "Putri",
      location: "Denpasar",
      price: 120000,
      condition: "Like New",
      createdAt: DateTime(2026, 7, 10),
    ),

    PostModel(
      id: "2",
      title: "Tas Ransel Eiger",
      category: "Aksesoris",
      description: "Tas ransel merk Eiger dengan kapasitas 30 liter, cocok untuk kegiatan sehari-hari seperti kuliah, kerja, atau traveling ringan. Kondisi 90% masih sangat baik, resleting semua masih normal dan tidak macet. Terdapat banyak kompartemen yang memudahkan penyimpanan laptop, botol minum, dan barang-barang kecil lainnya. Bahan anti air dan jahitan masih kuat. Hanya sedikit pemakaian di bagian bawah karena sering diletakkan di lantai. Serius minat? Langsung WA saya di 087654321098 untuk tanya stok dan negosiasi harga. Fast response, kok!",
      imageUrl: "assets/images/thrift2.jpeg",
      seller: "Budi",
      location: "Badung",
      price: 150000,
      condition: "Good",
      createdAt: DateTime(2026, 7, 8),
    ),

    PostModel(
      id: "3",
      title: "Sepatu Converse",
      category: "Fashion",
      description: "Sepatu kanvas klasik Converse Chuck Taylor ukuran 41. Masih nyaman dipakai dengan sol yang tebal dan tidak aus berlebihan. Bagian dalam sepatu masih bersih dan tidak ada bau yang tidak sedap. Tali sepatu masih original dan kuat. Warna hitam putih yang ikonik dan mudah dipadukan dengan gaya apapun. Cocok untuk pria maupun wanita yang menyukai gaya vintage dan santai. Harga bisa nego! Hubungi saya di 081298765432 via WhatsApp untuk tanya-tanya atau request foto lebih detail. Bisa cod juga di sekitar Gianyar.",
      imageUrl: "assets/images/thrift3.jpeg",
      seller: "Ayu",
      location: "Gianyar",
      price: 180000,
      condition: "Good",
      createdAt: DateTime(2026, 7, 6),
    ),

    PostModel(
      id: "4",
      title: "Meja Belajar Minimalis",
      category: "Furnitur",
      description: "Meja belajar dengan desain minimalis berbahan kayu jati yang masih kokoh dan kuat. Ukuran meja 120cm x 60cm dengan tinggi 75cm, sangat cocok untuk kamar kos atau ruang belajar di rumah. Kayu sudah di-finishing dengan cat bening sehingga terlihat natural dan elegan. Tidak ada goresan dalam atau retak pada permukaan meja. Kaki meja stabil dan tidak goyang. Sangat fungsional untuk menulis, membaca, atau meletakkan laptop. Minat? Langsung chat WhatsApp ke 085678901234 untuk tanya stok, kirim lokasi, atau negosiasi harga. Siap bantu antar kalau lokasi masih satu area!",
      imageUrl: "assets/images/thrift4.jpeg",
      seller: "Komang",
      location: "Tabanan",
      price: 250000,
      condition: "Used",
      createdAt: DateTime(2026, 7, 5),
    ),

    PostModel(
      id: "5",
      title: "Novel Bumi - Tere Liye",
      category: "Buku",
      description: "Novel laris karya Tere Liye yang pertama dari serial Bumi. Masih seperti baru karena baru dibaca sekali dan disimpan dengan baik di rak buku. Tidak ada halaman yang robek, lipatan, atau coretan di dalamnya. Sampul depan dan belakang masih mulus tanpa noda. Buku ini bercerita tentang petualangan Raib dan teman-temannya di dunia paralel. Sangat direkomendasikan untuk penggemar fiksi petualangan dan fantasi. Harga super murah! Buruan chat saya di 082345678901 via WhatsApp sebelum kehabisan. Bisa kirim foto kondisi buku lebih detail juga kalau mau.",
      imageUrl: "assets/images/thrift5.jpeg",
      seller: "Dewi",
      location: "Singaraja",
      price: 35000,
      condition: "Like New",
      createdAt: DateTime(2026, 7, 4),
    ),

    PostModel(
      id: "6",
      title: "Kursi Kantor",
      category: "Furnitur",
      description: "Kursi kantor ergonomis dengan sandaran tinggi dan busa tebal yang nyaman untuk duduk dalam waktu lama. Sistem hidrolik masih berfungsi dengan baik untuk mengatur ketinggian kursi. Roda kursi lengkap semua dan berjalan lancar di lantai keramik atau karpet. Sandaran tangan dapat disesuaikan. Kondisi kursi masih bagus, hanya ada sedikit pemakaian di bagian busa tetapi masih sangat nyaman. Cocok untuk bekerja dari rumah atau di kantor. Tertarik? Yuk, tanya-tanya dulu via WhatsApp ke 081567890123. Siap kasih diskon kalau ambil hari ini juga! Bisa cod atau kirim via ekspedisi.",
      imageUrl: "assets/images/thrift6.jpeg",
      seller: "Made",
      location: "Denpasar",
      price: 275000,
      condition: "Good",
      createdAt: DateTime(2026, 7, 2),
    ),
  ];
}