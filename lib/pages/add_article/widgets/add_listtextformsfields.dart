// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';
import 'package:provider/provider.dart';

class AddListTextFormsFields extends StatelessWidget {
  const AddListTextFormsFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final controller = Provider.of<AddController>(context);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextFormField(
                  'Título',
                  controller.titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SizedBox(
                  width: size.width * 0.2,
                  child: _buildTextFormField(
                    'Ano',
                    controller.yearController,
                  ),
                ),
              ),
            ],
          ),
          _buildTextFormField(
            'Resumo',
            controller.resumeController,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: size.width * 0.2,
                  child: _buildTextFormField(
                    'Curso',
                    controller.courseController,
                  ),
                ),
              ),
              Expanded(
                child: _buildTextFormField(
                  'Autor',
                  controller.authorController,
                ),
              ),
            ],
          ),
          _buildTextFormField(
            'Professor Orientador',
            controller.advisorController,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
    String labelText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
        keyboardType: labelText == 'Ano' ? TextInputType.number : null,
        inputFormatters: <TextInputFormatter>[
          if (labelText == 'Ano')
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Campo Obrigatório';
          } else if (labelText == 'Ano' && value.length > 4) {
            return 'Ano inválido';
          } else if (labelText == 'Ano' && int.parse(value) < 1600) {
            return 'Ano inválido';
          } else if (labelText == 'Ano' && int.parse(value) > 2030) {
            return 'Ano inválido';
          } else if (labelText == 'Resumo' && value.length > 1500) {
            return 'Texto muito grande! Max.: 1500 characteres';
          }
          return null;
        },
      ),
    );
  }
}
