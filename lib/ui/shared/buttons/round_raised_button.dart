import 'package:flutter/material.dart';

class RoundRaisedButton extends StatelessWidget {
  final Text textButton;
  final Function onPressedButton;

  const RoundRaisedButton(
      {@required this.textButton, @required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => onPressedButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[textButton],
        ),
      ),
    );
  }
}
