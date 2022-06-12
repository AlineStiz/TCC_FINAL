import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';

import 'package:provider/provider.dart';

class SubmitArticle extends StatelessWidget {
  const SubmitArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddController addController = Provider.of<AddController>(context);
    if (addController.isLoading) {
      return const CircularProgressIndicator(
        color: Color.fromARGB(255, 45, 49, 66),
      );
    }
    return addController.file == null
        ? const SizedBox.shrink()
        : InkWell(
            onTap: () async {
              await addController.save();
            },
            child: Container(
              width: 150,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 45, 49, 66),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    addController.isEdit ? 'Enviar edição' : 'Enviar artigo',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
  }
}
