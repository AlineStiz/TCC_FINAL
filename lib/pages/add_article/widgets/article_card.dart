// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:projeto_tcc/pages/add_article/widgets/add_image.dart';
import 'package:projeto_tcc/pages/add_article/widgets/add_listtextformsfields.dart';

import 'package:projeto_tcc/pages/add_article/widgets/file_widget.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Material(
          elevation: 50,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      AddImage(),
                      AddListTextFormsFields(),
                      FileWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
