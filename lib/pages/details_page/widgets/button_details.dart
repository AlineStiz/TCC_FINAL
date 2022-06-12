import 'package:flutter/material.dart';
import 'package:projeto_tcc/helpers/constants.dart';

class ButtonDetails extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  const ButtonDetails({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kBackGroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        width: 70,
        height: 40,
        child: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
