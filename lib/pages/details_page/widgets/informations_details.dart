// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:projeto_tcc/models/article.dart';
import 'package:projeto_tcc/pages/details_page/widgets/more_actions_details.dart';

class InformationDetails extends StatelessWidget {
  final Article article;
  const InformationDetails({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kDescriptionSize = Size(size.width * 0.6, size.height * 0.2);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (article.imageUploaded != 'null')
              SizedBox(
                height: 150,
                width: 150,
                child: Image.network(article.imageUploaded!),
              ),
            const VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: kDescriptionSize.width / 1.25,
                  height: kDescriptionSize.height / 2.5,
                  child: _buildText(
                    title:
                        'Título: ${article.title.toUpperCase()} - Ano: ${article.year}',
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
                _divider(),
                _buildText(
                  title: 'Autor: ${article.author}',
                  fontSize: 15,
                ),
                _divider(),
                _buildText(
                  title: 'Orientador: ${article.advisor}',
                  fontSize: 15,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        SizedBox(
          width: kDescriptionSize.width,
          height: kDescriptionSize.height,
          child: _buildText(
            title: article.description,
            textAlign: TextAlign.justify,
            fontSize: 15,
            maxLines: 5,
          ),
        ),
        const Divider(),
        MoreActionsDetails(article: article)
      ],
    );
  }

  Widget _divider() {
    return const SizedBox(height: 10);
  }

  Widget _buildText({
    required String title,
    FontWeight? fontWeight,
    int maxLines = 1,
    double fontSize = 20,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
