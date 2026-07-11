import '../model/post_model.dart';

class PostService {
  const PostService._();

  static List<PostModel> get posts => [
    PostModel(
      id: "1",
      title: "Jaket Denim Levi's",
      category: "Fashion",
      description:
          "Masih sangat bagus, jarang dipakai. Cocok untuk pria maupun wanita.",
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
      description: "Kondisi 90%, resleting masih normal, cocok untuk kuliah.",
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
      description: "Ukuran 41, masih nyaman dipakai, sol tebal.",
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
      description: "Kayu masih kokoh, cocok untuk kamar kos.",
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
      description: "Masih seperti baru, tidak ada halaman yang rusak.",
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
      description: "Hidrolik masih berfungsi, roda lengkap.",
      imageUrl: "assets/images/thrift6.jpeg",
      seller: "Made",
      location: "Denpasar",
      price: 275000,
      condition: "Good",
      createdAt: DateTime(2026, 7, 2),
    ),
  ];
}
