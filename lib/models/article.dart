// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String author;
  final String course;
  final String year;
  final String url;
  final String advisor;
  final String wasSendedBy;
  final String description;
  final String? imageUploaded;
  final String imageUploadedName;
  final String pdfName;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.course,
    required this.year,
    required this.url,
    required this.advisor,
    required this.wasSendedBy,
    required this.description,
    required this.imageUploaded,
    required this.imageUploadedName,
    required this.pdfName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'course': course,
      'year': year,
      'url': url,
      'advisor': advisor,
      'wasSendedBy': wasSendedBy,
      'description': description,
    };
  }

  factory Article.fromDocument(QueryDocumentSnapshot<dynamic> map) {
    return Article(
      id: map['id'].toString(),
      title: map['title'].toString(),
      course: map['course'].toString(),
      author: map['author'].toString(),
      year: map['year'].toString(),
      url: map['url'].toString(),
      description: map['description'].toString(),
      advisor: map['advisor'].toString(),
      wasSendedBy: map['wasSendedBy'].toString(),
      imageUploaded: map['imageUploaded'].toString(),
      imageUploadedName: map['imageUploadedName'].toString(),
      pdfName: map['pdfName'].toString(),
    );
  }

  String toJson() => json.encode(toMap());
}
