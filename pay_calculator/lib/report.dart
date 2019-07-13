import 'package:flutter/material.dart';
import 'work_view.dart';
import 'work_data.dart';

class Report extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: WorkList(kWork),
    );
  }
}
