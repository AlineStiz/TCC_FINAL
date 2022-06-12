// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/details_article_controller.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';

import 'package:projeto_tcc/models/article.dart';
import 'package:projeto_tcc/pages/details_page/widgets/button_details.dart';
import 'package:provider/provider.dart';

class MoreActionsDetails extends StatelessWidget {
  final Article article;
  const MoreActionsDetails({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsController controller =
        Provider.of<DetailsController>(context);

    final EditController editController = Provider.of<EditController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonDetails(
          onTap: () async => downloadFile(article.url),
          icon: Icons.download,
        ),
        if (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser!.email ==
                article.wasSendedBy) ...[
          ButtonDetails(
            onTap: () async => controller.remove(context, article.id, article.pdfName, article.imageUploadedName),
            icon: Icons.delete,
          ),
          ButtonDetails(
            onTap: () {
              editArticle(context);
              editController.openEditPage(article);
            },
            icon: Icons.edit,
          ),
        ]
      ],
    );
  }

  void editArticle(BuildContext context) {
    Navigator.pushNamed(context, '/edit');
  }

  void downloadFile(String url) {
    final html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
