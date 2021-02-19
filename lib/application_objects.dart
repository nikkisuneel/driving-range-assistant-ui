
import 'package:flutter/material.dart';

class Picker {
  int id;
  String name;
  String type;
  int throughput;

  Picker(this.name, this.type, this.throughput);

  factory Picker.fromJson(Map<String, dynamic> json) {
    Picker p = new Picker(
        json['name'].toString(),
        json['type'].toString(),
        json['throughput']
    );
    p.id = json["id"];
    return p;
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'type': type,
        'throughput': throughput
      };
}

class Activity {
  int id;
  DateTime currentDate;
  int ballCount;
  Map<Picker, int> picketCounts;
  DateTime startTime;
  DateTime endTime;

  Activity(this.currentDate, this.ballCount, this.picketCounts);
}

class GolfBallTrend {
  String key;
  int ballCount;

  GolfBallTrend(this.key, this.ballCount);
}

class ActivityTrend {
  String key;
  int activityTime;

  ActivityTrend(this.key, this.activityTime);
}

class PickerDatabase {
  static List<Picker> pickers;

  PickerDatabase() {
    pickers = <Picker> [
      new Picker("Hand Picker", "Manual", 10),
      new Picker("Slow Machine", "Automatic", 50),
      new Picker("Fast Machine", "Automatic", 100),
    ];
  }

  static void add(Picker picker) {
    pickers.add(picker);
  }

  static void edit(Picker picker) {
    for (var item in pickers) {
      if (item.name == picker.name) {
        item.type = picker.type;
        item.throughput = picker.throughput;
      }
    }
  }
}

// Class WidgetOptions consists of a widget and a title
class WidgetOptions {
  Widget widget;
  String title;

  WidgetOptions(this.widget, this.title);
}