 DateTime myDateTime = DateTime.now(); //2019-09-25 17:16:58.966855
 
 DateFormat.yMMMMd().format(myDateTime);//September 25, 2019
 DateFormat.yMMMd() .format(myDateTime);//Sep 25, 2019
 DateFormat.s().format(myDateTime);     //58
 DateFormat.d() .format(myDateTime);    //25
 DateFormat.E() .format(myDateTime);    //Wed
 DateFormat.EEEE() .format(myDateTime); //Wednesday
 DateFormat.H() .format(myDateTime);    //17
 DateFormat.Hm() .format(myDateTime);   //17:16
 DateFormat.Hms() .format(myDateTime);  //17:16:58
 DateFormat.jm().format(myDateTime);    //5:16 PM
 DateFormat.j() .format(myDateTime);    // 5 PM
 DateFormat.jms() .format(myDateTime);   //5:16:58 PM
 DateFormat.MMM() .format(myDateTime);   //Sep
 DateFormat.LLL() .format(myDateTime);   //Sep
 DateFormat.MMMM() .format(myDateTime);  //September
 DateFormat.LLLL() .format(myDateTime);  //September
 DateFormat.MMMMd() .format(myDateTime);   //September 25
 DateFormat.M() .format(myDateTime);      //9
 DateFormat.m() .format(myDateTime);     //16
 DateFormat.Md() .format(myDateTime);      //9/25
 DateFormat.MEd() .format(myDateTime);     //Wed, 9/25
 DateFormat.MMMd() .format(myDateTime);     //Sep 25
 DateFormat.MMMEd() .format(myDateTime);    //Wed, Sep 25
 DateFormat.MMMMEEEEd() .format(myDateTime); //Wednesday, September 25
 DateFormat.ms() .format(myDateTime);      //16:58
 DateFormat.QQQ() .format(myDateTime);    //Q3
 DateFormat.QQQQ() .format(myDateTime);   //3rd quarter
 DateFormat.y() .format(myDateTime);       //2019
 DateFormat.yM() .format(myDateTime);       //9/2019
 DateFormat.yMd() .format(myDateTime);      //9/25/2019
 DateFormat.yMEd().format(myDateTime);      //Wed, 9/25/2019
 DateFormat.yMMM().format(myDateTime);      //Sep 2019
DateFormat.yMMMd().format(myDateTime);      //Sep 25, 2019
DateFormat.yMMMEd().format(myDateTime);     // Wed, Sep 25, 2019
DateFormat.yMMMM() .format(myDateTime);      //September 2019
DateFormat.yMMMMd() .format(myDateTime);     //September 25, 2019
DateFormat.yMMMMEEEEd() .format(myDateTime); //Wednesday, September 25, 2019
DateFormat.yQQQ() .format(myDateTime);       //Q3 2019
DateFormat.yQQQQ() .format(myDateTime); //3rd quarter 2019
