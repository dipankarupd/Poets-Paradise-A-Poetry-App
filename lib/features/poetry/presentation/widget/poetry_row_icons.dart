import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/entities/profile.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/domain/entity/poetry.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';

class RowIcons extends StatefulWidget {
  final Icon unPressedIcon;
  final Icon pressedIcon;
  final String label;
  final Poetry poetry;
  final Profile currentUser;
  const RowIcons({
    super.key,
    required this.label,
    required this.unPressedIcon,
    required this.pressedIcon,
    required this.poetry,
    required this.currentUser,
  });

  @override
  State<RowIcons> createState() => _RowIconsState();
}

class _RowIconsState extends State<RowIcons> {
  bool isPressed = false;

  void _handleButtonPress() {
    setState(() {
      isPressed = !isPressed;
    });

    if (widget.label == 'Save') {
      context.read<PoetryBloc>().add(
            PoetrySaveButtonPressEvent(poetry: widget.poetry),
          );
    } else if (widget.label == 'Like') {
      context.read<PoetryBloc>().add(PoetryToggleLikeEvent(
            author: widget.currentUser.userId,
            poetry: widget.poetry.id,
            comment: '',
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        if (state is PoetryFailedState && widget.label == 'Save') {
          showSnackbar(context, state.message);
        } else if (state is PoetryFailedState && widget.label == 'Like') {
          showSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is PoetrySaveState && widget.label == 'Save') {
        } else if (state is PoetryToggleLikeState && widget.label == 'Like') {}
        return Row(
          children: [
            IconButton(
                onPressed: _handleButtonPress,
                icon: isPressed ? widget.pressedIcon : widget.unPressedIcon),
            Text(widget.label),
          ],
        );
      },
    );
  }
}
