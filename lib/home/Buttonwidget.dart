import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;

  final String text;

  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}

class ButtonWidget1 extends StatefulWidget {
  final IconData icon;

  final String text;

  final VoidCallback onClicked;

  const ButtonWidget1({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ButtonWidget1> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget1> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: widget.onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 28),
          SizedBox(width: 16),
          Text(
            widget.text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}
