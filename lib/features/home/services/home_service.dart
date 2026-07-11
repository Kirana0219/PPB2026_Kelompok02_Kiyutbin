import '../../blog/models/blog_model.dart';
import '../../blog/services/blog_service.dart';

class HomeService {
  final BlogService _blogService = BlogService();

  Future<List<BlogModel>> getLatestBlogs() async {
    final blogs = await _blogService.getAllBlogs();

    return blogs.take(3).toList();
  }

  List<HomeEventModel> getEvents() {
    return const [
      HomeEventModel(
        title: "Beach Cleanup",
        date: "20 July 2026",
        image: "assets/images/events/event1.jpg",
      ),

      HomeEventModel(
        title: "Tree Planting",
        date: "28 July 2026",
        image: "assets/images/events/event2.jpg",
      ),

      HomeEventModel(
        title: "Recycling Workshop",
        date: "02 August 2026",
        image: "assets/images/events/event3.jpg",
      ),
    ];
  }

  List<HomeBannerModel> getBanners() {
    return const [
      HomeBannerModel(
        image: "assets/images/banner/banner1.jpg",
        title: "Reduce Waste",
        subtitle:
            "Start sorting your waste today and create a cleaner environment.",
      ),

      HomeBannerModel(
        image: "assets/images/banner/banner2.jpg",
        title: "Recycle Today",
        subtitle: "Separate your waste correctly and protect nature.",
      ),

      HomeBannerModel(
        image: "assets/images/banner/banner3.jpg",
        title: "Save The Earth",
        subtitle: "Together we can build a greener future.",
      ),
    ];
  }
}

class HomeBannerModel {
  final String image;
  final String title;
  final String subtitle;

  const HomeBannerModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class HomeEventModel {
  final String title;
  final String date;
  final String image;

  const HomeEventModel({
    required this.title,
    required this.date,
    required this.image,
  });
}
