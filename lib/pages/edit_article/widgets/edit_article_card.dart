import 'package:flutter/material.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/add_image.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/list_buttons.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/textformfields_edit.dart';

class EditArticleCard extends StatelessWidget {
  const EditArticleCard({Key? key}) : super(key: key);

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
                      EditListTextFormsFields(),
                      EditListButtons(),
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
