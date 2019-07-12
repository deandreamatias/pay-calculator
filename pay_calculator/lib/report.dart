import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  final items = List<ListItem>.generate(
      1000,
      (i) => i % 3 == 0
          ? HeadingItem("Day $i")
          : MessageItem("Init $i", "Final $i", "$i"),
    );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: listPay(items),
    );
  }
}

Widget listPay (List<ListItem> items){

  return ListView.builder(
    // Let the ListView know how many items it needs to build.
    itemCount: items.length,
    // Provide a builder function. This is where the magic happens.
    // Convert each item into a widget based on the type of item it is.
    itemBuilder: (context, index) {
      final item = items[index];

      if (item is HeadingItem) {
        return ListTile(
          title: Text(
            item.heading,
            style: Theme.of(context).textTheme.headline,
          ),
        );
      } else if (item is MessageItem) {
        return listItem(context, item.initHour, item.finalHour, item.valueMoney);
      }
    },
  );
}

abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String initHour;
  final String finalHour;
  final String valueMoney;

  MessageItem(this.initHour, this.finalHour, this.valueMoney);
} 

Widget listItem (BuildContext context, initHour, String finalHour, String valueMoney){
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(initHour, style: Theme.of(context).textTheme.headline),
                  SizedBox(width: 16.0),
                  Text(finalHour, style: Theme.of(context).textTheme.headline)
                ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.euro_symbol),
                Text(valueMoney, style: Theme.of(context).textTheme.display1)
              ],
            ),
          )
        ],
      ),
  );
}
