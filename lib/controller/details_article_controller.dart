import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/article.dart';

class DetailsController extends ChangeNotifier {
  Article? article;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future remove(
    BuildContext context,
    String id,
    String? pdfName,
    String? imageName,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeDocument(id, pdfName, imageName);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Artigo foi removido com sucesso!'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Sim'),
          ),
        ],
        title: const Text('Deseja remover o artigo?'),
      ),
    );
  }

  Future _removeDocument(String id, String? pdfName, String? imageName) async {
    await _firestore.collection('articles').doc(id).delete();
    if (imageName != 'null') {
      _storage.ref('images').child(imageName!).delete();
    }
    if (pdfName != 'null') {
      _storage.ref('articles').child(pdfName!).delete();
    }
  }
}
