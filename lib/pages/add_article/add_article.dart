import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';

import 'package:projeto_tcc/pages/add_article/widgets/article_card.dart';
import 'package:provider/provider.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({Key? key}) : super(key: key);

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  late AddController article;

  @override
  Widget build(BuildContext context) {
    article = Provider.of<AddController>(context);
    return Scaffold(
      key: article.scaffoldAddKey,
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
        title: const Text('Adicionar Artigo'),
        centerTitle: true,
      ),
      body: const CustomScrollView(
        slivers: [ArticleCard()],
      ),
    );
  }
}
