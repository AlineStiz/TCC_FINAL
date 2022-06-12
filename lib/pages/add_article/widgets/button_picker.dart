import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';
import 'package:projeto_tcc/helpers/constants.dart';
import 'package:provider/provider.dart';

class ButtonPicker extends StatelessWidget {
  const ButtonPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddController addController = Provider.of<AddController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => addController.pickAndUploadFile(),
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
                if (addController.total != 0 && addController.total < 100)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                      value: addController.total / 100,
                      strokeWidth: 2,
                    ),
                  )
                else
                  Icon(
                    getIcon(addController),
                    color: Colors.white,
                  ),
                Text(
                  getText(addController),
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

  String getText(AddController addController) {
    return addController.file == null
        ? 'Adicionar o arquivo'
        : 'Arquivo selecionado';
  }

  IconData getIcon(AddController addController) {
    if (addController.isEdit || addController.archiveSelected != null) {
      return Icons.done;
    } else {
      return Icons.add;
    }
  }
}
