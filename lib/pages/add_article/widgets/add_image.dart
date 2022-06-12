import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';
import 'package:provider/provider.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddController addController = Provider.of<AddController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            addController.pickImageFromGallery();
          },
          child: const Text('Adicionar imagem'),
        ),
        if (addController.imageSelected != null)
          Flexible(
            child: Text('Imagem Selecionada: ${addController.imageSelected}'),
          ),
      ],
    );
  }
}
