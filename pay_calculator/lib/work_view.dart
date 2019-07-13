import 'package:flutter/material.dart';
import 'work_data.dart';

class WorkList extends StatelessWidget {

  final List<Work> _work;

  WorkList(this._work);

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: _buildWorkList()
        );
  }

  List<_WorkListItem> _buildWorkList() {
    return _work.map((work) => _WorkListItem(work))
                    .toList();
  }
}

class _WorkListItem extends StatelessWidget {
  final Work _work;

  _WorkListItem(this._work);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: _titleItem(_work.inithour, _work.finalHour),
      leading: Text(_work.date.day.toString()),
      trailing: Text(_work.money.toString()),
    );
  }

  Widget _titleItem (TimeOfDay initHour, TimeOfDay finalHour){
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_formatText(initHour)),
          SizedBox(width: 16.0),
          Text(_formatText(finalHour))
        ],
    );
  }

  String _formatText (TimeOfDay hour){
    return hour.hour.toString() + ":" + hour.minute.toString();
  }
}
