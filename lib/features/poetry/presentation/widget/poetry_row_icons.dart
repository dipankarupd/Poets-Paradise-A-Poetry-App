import 'package:flutter/material.dart';

class RowIcons extends StatefulWidget {
  final Icon unPressedIcon;
  final Icon pressedIcon;
  final String label;
  const RowIcons({
    super.key,
    required this.label,
    required this.unPressedIcon,
    required this.pressedIcon,
  });

  @override
  State<RowIcons> createState() => _RowIconsState();
}

class _RowIconsState extends State<RowIcons> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              isPressed = !isPressed;
              setState(() {});
            },
            icon: isPressed ? widget.pressedIcon : widget.unPressedIcon),
        Text(widget.label),
      ],
    );
  }
}
