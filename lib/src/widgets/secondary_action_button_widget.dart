import 'package:flutter/material.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const SecondaryActionButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 0)),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        maximumSize: MaterialStateProperty.all(Size.infinite),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 18,
          fontFamily: 'GothamMedium',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
