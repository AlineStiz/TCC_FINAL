
import 'package:flutter/material.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/button_picker.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/submit_edit_article.dart';

class EditListButtons extends StatelessWidget {

  const EditListButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                EditButtonPicker(),
              ],
            ),
            const EditSubmitArticle(),
          ],
        ),
      ],
    );
  }
}
