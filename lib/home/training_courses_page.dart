import 'package:flutter/material.dart';
import 'package:fapp/model/training_course.dart';

class TrainingCoursesScreen extends StatelessWidget {
  List<TrainingCourse> courses = [
    TrainingCourse(
      sectionTitle: "Computer Science",
      videos: [
        Video(
            title: "Introduction to algorithms",
            description: "A comprehensive overview of algorithms",
            image: "https://i.ytimg.com/vi/zOjov-2OZ0E/maxresdefault.jpg",
            videoLink: "https://example.com/intro-to-algorithms-video"),
        Video(
            title: "Data Structures and algorithms",
            description: "A detailed look at data structures and algorithms",
            image: "https://i.ytimg.com/vi/RBSGKlAvoiM/maxresdefault.jpg",
            videoLink: "https://example.com/data-structures-algorithms-video"),
      ],
    ),
    TrainingCourse(
      sectionTitle: "Mathematics",
      videos: [
        Video(
            title: "Calculus I",
            description: "A comprehensive overview of calculus",
            image: "https://i.ytimg.com/vi/p3Cohshlw90/maxresdefault.jpg",
            videoLink: "https://example.com/calculus-1-video"),
        Video(
            title: "Linear Algebra",
            description: "A detailed look at linear algebra",
            image: "https://i.ytimg.com/vi/Ft2_QtXAnh8/maxresdefault.jpg",
            videoLink: "https://example.com/linear-algebra-video"),
      ],
    ),
    TrainingCourse(
      sectionTitle: "Business Management",
      videos: [
        Video(
            title: "Introduction to Business",
            description: "A comprehensive overview of business",
            image:
                "https://quickbooks.intuit.com/oidam/intuit/sbseg/en_us/Blog/Photography/Stock/01-executive-summary-us-en.jpg",
            videoLink: "https://example.com/intro-to-business-video"),
        Video(
            title: "Marketing Management",
            description: "A detailed look at marketing management",
            image:
                "https://d1m75rqqgidzqn.cloudfront.net/wp-data/2021/11/08151731/marketing-management-job-roles-1024x576.jpg",
            videoLink: "https://example.com/marketing-management-video"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: courses
            .map((course) => ExpansionTile(
                  title: Text(course.sectionTitle),
                  children: course.videos
                      .map((video) => ListTile(
                            title: Text(video.title),
                            subtitle: Text(video.description),
                            leading: Image.network(video.image),
                            onTap: () {
                              // open video
                            },
                          ))
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
