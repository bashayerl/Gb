import 'package:flutter/material.dart';
import 'package:fapp/home/projects_list.dart';

import 'package:fapp/model/project.dart';

class ProjectCategoryDetailsPage extends StatelessWidget {
  // final ProjectCaetgorie projectCategory;
  final String heroTag;
  final String title;
  final String image;
  final String description;
  final List<Project> projects;

  ProjectCategoryDetailsPage(
      {super.key,
      required this.heroTag,
      required this.title,
      required this.image,
      required this.description,
      required this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: heroTag,
              child: Image.network(
                image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  // Text(
                  //   title,
                  //   style: const TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // Text(description),
                  ProjectList(projectsList: projects)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
