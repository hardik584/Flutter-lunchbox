 SharedPreferences pre = await SharedPreferences.getInstance();

  DateTime tokenCheck = DateTime.parse(pre.getString(expiredTokenTime));
  if (tokenCheck.isBefore(DateTime.now())) {
    FirebaseUser a = await FirebaseAuth.instance.currentUser();
    var temp = await a.getIdToken(refresh: true);

    print(temp.token);
    print(temp.expirationTime);

    pre.setString(expiredTokenTime, temp.token);
    pre.setString("token", temp.token);
  }
