import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';

import 'package:provider/provider.dart';

class EditSubmitArticle extends StatelessWidget {
  const EditSubmitArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditController editController = Provider.of<EditController>(context);
    if (editController.isLoading) {
      return const CircularProgressIndicator(
        color: Color.fromARGB(255, 45, 49, 66),
      );
    }
    return _buildSubmitButton(editController);
  }

  Widget _buildSubmitButton(EditController editController) {
    return InkWell(
      onTap: () async {
        await editController.save();
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
          children: const [
            Text(
              'Enviar edição',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
