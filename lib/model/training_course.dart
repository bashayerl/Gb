class TrainingCourse {
  final String sectionTitle;
  final List<Video> videos;

  TrainingCourse({required this.sectionTitle, required this.videos});
}

class Video {
  final String title;
  final String description;
  final String image;
  final String videoLink;

  Video(
      {required this.title,
      required this.description,
      required this.image,
      required this.videoLink});
}
