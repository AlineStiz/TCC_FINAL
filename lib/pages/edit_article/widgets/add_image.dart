import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';
import 'package:provider/provider.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditController editController = Provider.of<EditController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            editController.pickImageFromGallery();
          },
          child: const Text('Editar imagem'),
        ),
        if (editController.imageSelected != null)
          Flexible(
            child: Text('Imagem Selecionada: ${editController.imageSelected}'),
          ),
      ],
    );
  }
}
