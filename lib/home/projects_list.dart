import 'package:flutter/material.dart';
import 'package:fapp/home/pdf_view_screen.dart';
import 'package:fapp/model/project.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projectsList;

  const ProjectList({
    key,
    required this.projectsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projectsList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showLoaderDialog(context);
            createFileOfPdfUrl(projectsList[index].projectPdfLink).then((f) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFViewScreen(path: f.path)),
              );
            });
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(projectsList[index].image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            projectsList[index].title,
                            maxLines: 2,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            projectsList[index].author,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Text(
                            projectsList[index].description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "Read more",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(58, 66, 86, 1.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
