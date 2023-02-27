import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:permission_handler/permission_handler.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:file_picker/file_picker.dart';

class PDFViewScreen extends StatefulWidget {
  final String path;

  PDFViewScreen({required this.path});

  _PDFViewScreenState createState() => _PDFViewScreenState();
}

Future<File> createFileOfPdfUrl(String url) async {
  Completer<File> completer = Completer();
  try {
    final fileName = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/$fileName");

    await file.writeAsBytes(bytes, flush: true);
    completer.complete(file);
  } catch (e) {
    throw Exception('Error downloading pdf file!');
  }

  return completer.future;
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: EdgeInsets.only(left: 7),
            child: const Text("Loading project...")),
      ],
    ),
  );
  showDialog(
    useRootNavigator: false,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  late int level = 0;

  @override
  void initState() {
    super.initState();
    fetchUserLevel();
  }

  void fetchUserLevel() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;

    final databaseReference = FirebaseDatabase.instance.reference();
    final snapshot =
        await databaseReference.child("users").child(uid).child("level").once();

    print("snapshot -------> ");
    print(snapshot.snapshot.value);
    print("id -------> ");

    print(uid);
    setState(() {
      level = snapshot.snapshot.value
          as int; // Use "default" if level is not set in the database
    });
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await Permission.storage.request().isGranted) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/$fileName";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project documentation"),
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onPageChanged: (page, total) {
              print('page change: $page/$total');
            },
          ),
          if (level >= 13)
            Align(
              alignment: Alignment(-1, 0.9),
              child: MaterialButton(
                onPressed: () {
                  var saved_file = saveFile(
                      'https://www.africau.edu/images/default/sample.pdf',
                      "sample pdf");

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Dwonload file.."),
                        content: Text(
                            "The project file has been downloaded succesfully"),
                        actions: [
                          TextButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                color: const Color.fromARGB(255, 114, 152, 183),
                textColor: Colors.white,
                child: Icon(
                  Icons.download,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
