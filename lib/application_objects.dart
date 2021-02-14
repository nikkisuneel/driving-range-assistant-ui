
class Picker {
  String name;
  String type;
  int throughPut;

  Picker(this.name, this.type, this.throughPut);
}

class Activity {
  DateTime currentDate;
  int ballCount;
  Map<Picker, int> picketCounts;
  DateTime startTime;
  DateTime endTime;

  Activity(this.currentDate, this.ballCount, this.picketCounts);
}

class Trends {
  Map<String, int> ballCounts;
  Map<String, String> activityTime;

  Trends(this.ballCounts, this.activityTime);
}