
/*
 * Copyright (c) 2021, Nikhila (Nikki) Suneel. All Rights Reserved.
 */

import 'dart:convert';

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
        json['throughput'] as int
    );
    p.id = json["id"] as int;

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
  DateTime activityDate;
  int ballCount;
  Map<String, int> pickerCounts;
  DateTime startTime;
  DateTime endTime;

  Activity(this.activityDate, this.ballCount, this.pickerCounts);

  factory Activity.fromJson(Map<String, dynamic> json) {
    Activity p = new Activity(
        DateTime.parse(json['activityDate']),
        json["ballCount"] as int,
        Map<String, int>.from(json["pickerCounts"]),
    );
    p.id = json["id"] as int;

    if (json.containsKey("startTime")) {
      p.startTime = DateTime.parse(json['startTime']);
    }

    if (json.containsKey("endTime")) {
      p.endTime = DateTime.parse(json['endTime']);
    }

    return p;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = new Map();

    result['activityDate'] = activityDate.toIso8601String();
    result['ballCount'] = ballCount;
    result["pickerCounts"] = pickerCounts;

    if (startTime != null) {
      result['startTime'] = startTime.toIso8601String();
    }

    if (endTime != null) {
      result['endTime'] = endTime.toIso8601String();
    }

    return result;
  }
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

class TrendData {
  Map<String, int> ballCountData;
  Map<String, int> activityTimeData;

  TrendData(this.ballCountData, this.activityTimeData);

  factory TrendData.fromJson(Map<String, dynamic> json) {
    TrendData tdo = new TrendData(
        Map<String,int>.from(json["ballCountData"]),
        Map<String,int>.from(json["activityTimeData"])
    );

    return tdo;
  }
}

class DataTrendObject {
  TrendData monthly;
  TrendData daily;

  DataTrendObject(this.monthly, this.daily);

  factory DataTrendObject.fromJson(Map<String, dynamic> json) {
    DataTrendObject dto = new DataTrendObject(
        TrendData.fromJson(json["monthly"]),
        TrendData.fromJson(json["daily"]),
    );

    return dto;
  }
}

// Class WidgetOptions consists of a widget and a title
class WidgetOptions {
  Widget widget;
  String title;

  WidgetOptions(this.widget, this.title);
}