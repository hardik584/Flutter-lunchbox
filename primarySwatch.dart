
MaterialColor colorCustom = MaterialColor(0xFF0e8664, color);
Map<int, Color> color = {
  50: Color.fromRGBO(14,134,100, .1),
  100: Color.fromRGBO(14,134,100, .2),
  200: Color.fromRGBO(14,134,100, .3),
  300: Color.fromRGBO(14,134,100, .4),
  400: Color.fromRGBO(14,134,100, .5),
  500: Color.fromRGBO(14,134,100, .6),
  600: Color.fromRGBO(14,134,100, .7),
  700: Color.fromRGBO(14,134,100, .8),
  800: Color.fromRGBO(14,134,100, .9),
  900: Color.fromRGBO(14,134,100, 1),
};

return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.orangeAccent, elevation: 0,brightness: Brightness.light,),
        primarySwatch: colorCustom,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
    
    //for using hax value in MaterialColor just like
    	#0040ff  => 0xFF0040ff 
