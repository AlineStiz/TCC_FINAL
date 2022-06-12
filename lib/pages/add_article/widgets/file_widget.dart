import 'package:flutter/material.dart';
import 'package:projeto_tcc/pages/add_article/widgets/button_picker.dart';
import 'package:projeto_tcc/pages/add_article/widgets/submit_article.dart';

class FileWidget extends StatelessWidget {

  const FileWidget({
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
                ButtonPicker(),
              ],
            ),
            const SubmitArticle(),
          ],
        ),
      ],
    );
  }
}
