import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';
import 'package:projeto_tcc/pages/edit_article/widgets/edit_article_card.dart';
import 'package:provider/provider.dart';

class EditArticlePage extends StatefulWidget {
  const EditArticlePage({Key? key}) : super(key: key);

  @override
  State<EditArticlePage> createState() => _EditArticlePageState();
}

class _EditArticlePageState extends State<EditArticlePage> {
  @override
  Widget build(BuildContext context) {
    final EditController editController = Provider.of<EditController>(context);
    return Scaffold(
      key: editController.scaffoldKey,
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo1.png'),
            )
          ],
        ),
      appBar: AppBar(
        title: const Text('Editar Artigo'),
        centerTitle: true,
      ),
      body: const CustomScrollView(
        slivers: [
          EditArticleCard(),
        ],
      ),
    );
  }
}
