import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  final Widget child;
  final Function onTap;

  RippleEffect({@required this.child, this.onTap});

 @override
 Widget build(BuildContext context) {
 return Stack(
     children: <Widget>[
     child,
      Positioned.fill(
        child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: onTap,
            ))),
      ],
    );
  }
}