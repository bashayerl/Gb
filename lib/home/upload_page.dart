import 'dart:io';

import 'package:fapp/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  final String userId = "";

  //UploadPage({required this.userId});

  @override
  _UploadPdfScreenState createState() => _UploadPdfScreenState();
}

class _UploadPdfScreenState extends State<UploadPage> {
  File? _pdfFile;

  Future<void> _selectPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> _uploadPdf() async {
    if (_pdfFile == null) {
      // No PDF file selected
      return;
    }

    // Upload the PDF file to Firebase Storage
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('pdfs/${DateTime.now().millisecondsSinceEpoch}.pdf');
    UploadTask uploadTask = storageRef.putFile(_pdfFile!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Save the download URL to the user's data in Firebase Realtime Database
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/${widget.userId}');
    await userRef.update({
      'pdfUrl': downloadUrl,
    });

    // Show a success message
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('PDF uploaded'),
        content:
            Text('The PDF file has been uploaded and saved to your profile.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
        backgroundColor: const Color.fromRGBO(39, 66, 86, 1.0),
      ),
      backgroundColor: HexColor.fromHex('#EEEAE5'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_pdfFile == null)
              ElevatedButton(
                onPressed: _selectPdfFile,
                child: Text('Select PDF file'),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(_pdfFile!.path),
              ),
            ElevatedButton(
              onPressed: _uploadPdf,
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
