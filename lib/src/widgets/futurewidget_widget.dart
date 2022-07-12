import 'package:flutter/material.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget(
      {super.key,
      required this.future,
      required this.successWidget,
      required this.errorWidget,})
     ;

  final Future<String> future;
  final Widget successWidget;
  final Widget errorWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return successWidget;
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return errorWidget;
        }
        return Container();
      },
    );
  }
}
