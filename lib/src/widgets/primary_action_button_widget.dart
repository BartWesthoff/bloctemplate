import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const PrimaryActionButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        splashFactory: InkRipple.splashFactory,
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        maximumSize: MaterialStateProperty.all(Size.infinite),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'GothamMedium',
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
