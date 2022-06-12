import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddController extends ChangeNotifier {
  Uint8List? file;
  String? archiveSelected;
  String? imageSelected;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? uploadedPhotoUrl;
  bool isLoading = false;
  double total = 0;
  final formKey = GlobalKey<FormState>();
  final scaffoldAddKey = GlobalKey<ScaffoldState>();
  final scaffoldDetailsKey = GlobalKey<ScaffoldState>();
  bool isEdit = false;
  String? id;

  Uint8List? imageFile;
  String? imageUploaded;
  String? imageUploadedName;

  TextEditingController titleController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController advisorController = TextEditingController();

  Future pickImageFromGallery() async {
    notifyListeners();
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png', 'gif'],
    );

    if (result != null) {
      imageSelected = result.files.single.name;
      if (imageFile != result.files.single.bytes) total = 0;
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
    final Reference _reference = storage.ref('images').child(imageSelected!);
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

  Future uploadDocument() async {
    final Reference _reference =
        storage.ref('articles').child(archiveSelected!);
    await _reference.putData(
      file!,
    ).then((element) async => uploadedPhotoUrl = await element.ref.getDownloadURL());
  }

  Future<void> filePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      archiveSelected = result.files.single.name;
      if (file != result.files.single.bytes) total = 0;
      file = result.files.single.bytes;
      notifyListeners();
    }
  }

  Future pickAndUploadFile() async {
    await filePicker();
  }

  void validator() {
    if (formKey.currentState!.validate()) {}
  }

  Future save() async {
    final BuildContext context =
        scaffoldAddKey.currentContext ?? scaffoldDetailsKey.currentContext!;
    final int random = Random().nextInt(1000000000);
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
          if (imageSelected != null) await uploadImagetoFireBase();
          await uploadDocument();
          await firestore.collection('articles').doc('$random').set({
            'id': random,
            'author': authorController.text,
            'course': courseController.text,
            'title': titleController.text,
            'description': resumeController.text,
            'url': uploadedPhotoUrl,
            'pdfName': archiveSelected,
            'year': yearController.text,
            'advisor': advisorController.text,
            'wasSendedBy': FirebaseAuth.instance.currentUser!.email.toString(),
            'imageUploaded': imageUploaded,
            'imageUploadedName': imageSelected,
          });
          isLoading = false;
          notifyListeners();
          closePage();
          clean();
          _buildSnackBar(
            context: context,
            content: 'Artigo foi enviado com sucesso!',
            duration: 3,
          );
        }
      } catch (e) {
        isLoading = false;
        notifyListeners();
        _buildSnackBar(
          context: context,
          content: 'Erro ao salvar o artigo: $e',
          duration: 2,
        );
      }
    }
  }

  void closePage() {
    Navigator.pop(scaffoldAddKey.currentContext!);
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
    uploadedPhotoUrl = null;
    file = null;
    archiveSelected = null;
    total = 0;
    isEdit = false;
    imageUploaded = null;
    imageUploadedName = null;

    imageSelected = null;
    imageFile = null;
    notifyListeners();
  }
}
