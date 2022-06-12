import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/article.dart';

class EditController extends ChangeNotifier {
  String? archiveSelected;
  String? uploadedPdfUrl;
  final _storage = FirebaseStorage.instance;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? articleId;
  String? pdfName;
  Uint8List? file;
  Uint8List? imageFile;
  String? imageUploaded;
  String? imageSelected;
  String? imageUploadedName;
  bool isLoading = false;
  final firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController advisorController = TextEditingController();

  Future pickImageFromGallery() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      imageSelected = result.files.single.name;
      imageFile = result.files.single.bytes;

      notifyListeners();
    }
    notifyListeners();
  }

  String getImageSettable() {
    final type = imageSelected!.split('.').last;
    return 'image/$type';
  }

  Future uploadImagetoFireBase() async {
    final Uint8List file = imageFile!;
    final Reference _reference = _storage.ref('images').child(imageSelected!);
    await _reference
        .putData(
          file,
          SettableMetadata(contentType: getImageSettable()),
        )
        .then(
          (element) async => imageUploaded = await element.ref.getDownloadURL(),
        );
    notifyListeners();
  }

  void openEditPage(Article article) {
    articleId = article.id;
    titleController.text = article.title;
    yearController.text = article.year;
    resumeController.text = article.description;
    courseController.text = article.course;
    authorController.text = article.author;
    advisorController.text = article.advisor;
    uploadedPdfUrl = article.url;
    imageUploaded = article.imageUploaded;
    imageUploadedName = article.imageUploadedName;
    pdfName = article.pdfName;

    notifyListeners();
  }

  Future pickAndUploadFile() async {
    await filePicker();
  }

  Future uploadDocument() async {
    final Reference _reference =
        _storage.ref('articles').child(archiveSelected!);
    await _reference
        .putData(
          file!,
        )
        .then(
          (element) async =>
              uploadedPdfUrl = await element.ref.getDownloadURL(),
        );
  }

  Future<void> filePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      archiveSelected = result.files.single.name;
      file = result.files.single.bytes;
      notifyListeners();
    }
  }

  Future _removeDocument(String? pdfName, String? imageName) async {
    try {
      if (imageName != 'null') {
        if (imageSelected != null) {
          await _storage.ref('images').child(imageName!).delete();
        }
      }
      if (pdfName != 'null') {
        if (file != null) {
          await _storage.ref('articles').child(pdfName!).delete();
        }
      }
    } catch (e) {
      log('erro ao apagar: $e');
    }
  }

  Future save() async {
    final BuildContext context = scaffoldKey.currentContext!;
    isLoading = true;
    notifyListeners();
    if (!formKey.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        if (FirebaseAuth.instance.currentUser == null) {
          isLoading = false;
          notifyListeners();
          _buildSnackBar(
            context: context,
            content: 'Faça login para salvar!',
            duration: 5,
            action: SnackBarAction(
              label: 'Fazer Login',
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                );
              },
            ),
          );
        } else {
          await _removeDocument(pdfName, imageUploadedName);
          if (imageSelected != null) await uploadImagetoFireBase();
          if (file != null) await uploadDocument();
          await firestore.collection('articles').doc('$articleId').update({
            'author': authorController.text,
            'course': courseController.text,
            'title': titleController.text,
            'description': resumeController.text,
            'url': uploadedPdfUrl,
            'year': yearController.text,
            'advisor': advisorController.text,
            'wasSendedBy': FirebaseAuth.instance.currentUser!.email.toString(),
            'pdfName': archiveSelected ?? pdfName,
            'imageUploaded': imageUploaded,
            'imageUploadedName': imageSelected ?? imageUploadedName,
          });
          isLoading = false;
          notifyListeners();
          pushToHomePage();
          clean();
          _buildSnackBar(
            context: context,
            content: 'Artigo editado com sucesso!',
            duration: 3,
          );
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        _buildSnackBar(
          context: context,
          content: 'Erro ao editar o artigo: $e',
          duration: 2,
        );
      }
    }
  }

  void pushToHomePage() {
    Navigator.pushReplacementNamed(scaffoldKey.currentContext!, '/home');
  }

  void _buildSnackBar({
    required BuildContext context,
    required String content,
    required int duration,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
        action: action,
        duration: Duration(seconds: duration),
      ),
    );
  }

  void clean() {
    titleController.clear();
    yearController.clear();
    resumeController.clear();
    courseController.clear();
    authorController.clear();
    advisorController.clear();
    uploadedPdfUrl = null;
    file = null;
    archiveSelected = null;

    imageSelected = null;

    notifyListeners();
  }
}
