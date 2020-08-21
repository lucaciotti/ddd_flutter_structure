import 'package:flutter/material.dart';

class RoundOutlineButton extends StatelessWidget {
  final ImageProvider imageButton;
  final Text textButton;
  final Function onPressedButton;

  const RoundOutlineButton(
      {this.imageButton,
      @required this.textButton,
      @required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () => onPressedButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: const BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: imageButton, height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: textButton,
            )
          ],
        ),
      ),
    );
  }
}
