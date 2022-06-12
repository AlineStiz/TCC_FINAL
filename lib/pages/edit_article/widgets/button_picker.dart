import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';
import 'package:projeto_tcc/helpers/constants.dart';
import 'package:provider/provider.dart';

class EditButtonPicker extends StatelessWidget {
  const EditButtonPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditController editController = Provider.of<EditController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => editController.pickAndUploadFile(),
          child: Container(
            decoration: const BoxDecoration(
              color: kBackGroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            height: 50,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  getIcon(editController),
                  color: Colors.white,
                ),
                Text(
                  getText(editController),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String getText(EditController editController) {
    return editController.file == null
        ? 'Alterar arquivo'
        : 'Arquivo selecionado';
  }

  IconData getIcon(EditController editController) {
    if (editController.uploadedPdfUrl != null ||
        editController.archiveSelected != null) {
      return Icons.done;
    } else {
      return Icons.add;
    }
  }
}
