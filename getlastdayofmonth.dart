int getLastDayofMonth(DateTime now){
    var beginningNextMonth = (now.month < 12) ? new DateTime(now.year, now.month + 1, 1) : new DateTime(now.year + 1, 1, 1);
    var lastDay = beginningNextMonth.subtract(new Duration(days: 1)).day;

    return lastDay;

  }
