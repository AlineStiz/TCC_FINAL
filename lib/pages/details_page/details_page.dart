// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/article.dart';
import 'package:projeto_tcc/pages/details_page/widgets/informations_details.dart';

class DetailsPage extends StatelessWidget {
  final Article article;
  const DetailsPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final kPadding = EdgeInsets.fromLTRB(
      size.width * 0.05,
      size.height * 0.10,
      size.width * 0.05,
      size.height * 0.10,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais Informações'),
        centerTitle: true,
      ),
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo1.png'),
            )
          ],
        ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: kPadding,
              child: Hero(
                tag: article.id,
                child: Material(
                  elevation: 15,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: InformationDetails(
                              article: article,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
