class LeaveHistoryData {
  String _status;
  String _date;
  String _comment;
  String _applied_time;
  String _reason;
  String _updated_time;

  LeaveHistoryData(this._status, this._date, this._comment, this._applied_time,
      this._reason, this._updated_time);

  LeaveHistoryData.map(dynamic obj) {
    this._status = obj["status"];
    this._date = obj["date"];
    this._comment = obj["comment"];
    this._applied_time = obj["applied_time"];
    this._reason = obj["reason"];
    this._updated_time = obj["updated_time"];
  }

  String get status => _status;
  String get date => _date;
  String get comment => _comment;
  String get applied_time => _applied_time;
  String get reason => _reason;
  String get updated_time => _updated_time;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["status"] = _status;
    map["date"] = _date;
    map["comment"] = _comment;
    map["applied_time"] = _applied_time;
    map["reason"] = _reason;
    map["updated_time"] = _updated_time;

    return map;
  }
}
