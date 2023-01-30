import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grodudes/core/configurations/styles.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Styles.colorPrimary,
      ),
    );
  }
}
