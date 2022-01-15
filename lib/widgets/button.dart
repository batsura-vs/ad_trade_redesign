import 'package:flutter/material.dart';

class OutlineIconButton extends StatelessWidget {
  final onTap, text, styleText, color, icon;
  const OutlineIconButton({Key? key, this.onTap, this.text, this.styleText, this.color, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  text,
                  style: styleText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
