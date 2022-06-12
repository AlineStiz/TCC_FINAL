// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:projeto_tcc/models/article.dart';

class RCard extends StatelessWidget {
  final Article article;
  const RCard({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Hero(
        tag: article.id,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          child: ListTile(
            leading: article.imageUploaded == 'null'
                ? null
                : Image(
                    image: NetworkImage(
                      article.imageUploaded!,
                    ),
                  ),
            onTap: () =>
                Navigator.pushNamed(context, '/details', arguments: article),
            title: Text('Título: ${article.title} - Ano: ${article.year}'),
            subtitle: Text(
              'Autor: ${article.author}\nOrientador: ${article.advisor}',
            ),
          ),
        ),
      ),
    );
  }
}
