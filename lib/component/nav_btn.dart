import 'package:flutter/material.dart';

class NavBtn extends StatelessWidget {
  const NavBtn({Key key, @required this.icon, @required this.fun})
      : super(key: key);
  final IconData icon;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.4),
            borderRadius: BorderRadius.circular(20)),
        // padding: EdgeInsets.only(right: 20, bottom: 15),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
