import 'package:flutter/material.dart';
import 'package:fapp/home/categorie_details_page.dart';
import 'package:fapp/model/categories.dart';

class HomePage extends StatelessWidget {
  final List _projectCaetgories = ProjectCaetgorie.allProjectCaetgories();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getHomePageBody(context));
  }

  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _projectCaetgories.length,
      itemBuilder: _getItemUI,
    );
  }

  Widget _getItemUI(BuildContext context, int index) {
    return Hero(
      tag: index.toString(),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectCategoryDetailsPage(
                    heroTag: index.toString(),
                    description: _projectCaetgories[index].description,
                    image: _projectCaetgories[index].image,
                    title: _projectCaetgories[index].title,
                    projects: _projectCaetgories[index].projects),
              ),
            );
          },
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Stack(
                      children: <Widget>[
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.srcATop),
                          child: Image.network(
                            _projectCaetgories[index].image,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                        Center(
                          child: Text(
                            _projectCaetgories[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      _projectCaetgories[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_projectCaetgories[index]
                                .description
                                .toString()
                                .length >
                            120
                        ? "${_projectCaetgories[index].description.toString().substring(0, 120)}..."
                        : _projectCaetgories[index].description.toString()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
