import 'package:flutter/material.dart';
import 'custom_shape_clipper.dart';
import 'package:intl/intl.dart';
import 'custom_app_bar.dart';
import 'flight_list.dart';

void main() => runApp(MaterialApp(
      title: 'Hero',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            homeScreenBottomPart,
            homeScreenBottomPart,
          ],
        ),
      ),
    );
  }
}

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);
ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF3791A),
  fontFamily: 'SF-Pro-Text-Bold',
);

List<String> locations = ['Boston (Bos)', 'New York City(NYC)'];

TextStyle dropDownLableStyle = TextStyle(color: Colors.white, fontSize: 16.0);
TextStyle dropDownItemStyle = TextStyle(color: Colors.black, fontSize: 18.0);

class HomeScreenTopPart extends StatefulWidget {
  HomeScreenTopPart({Key key}) : super(key: key);

  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationindex = 0;
  final _searchFiledController = TextEditingController(text: locations[1]);
  @override
  Widget build(BuildContext context) {
    var isFlightSelected = true;
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, secondColor])),
              height: 400.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        PopupMenuButton(
                          onSelected: (index) {
                            setState(() {
                              selectedLocationindex = index;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(locations[selectedLocationindex],
                                  style: dropDownLableStyle),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  child: Text(
                                    locations[0],
                                    style: dropDownItemStyle,
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    locations[1],
                                    style: dropDownItemStyle,
                                  ),
                                  value: 1,
                                )
                              ],
                        ),
                        Spacer(),
                        Icon(Icons.settings, color: Colors.white)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Where would\nyou want to go?',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: TextField(
                          controller: TextEditingController(text: locations[1]),
                          style: dropDownItemStyle,
                          cursorColor: appTheme.primaryColor,
                          decoration: InputDecoration(
                              suffixIcon: Material(
                                elevation: 2.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InheritedFlightListing(fromLocation: locations[selectedLocationindex], toLocation:  _searchFiledController.text,child: FlightList(),)));
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 14.0)),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            setState(() {
                              isFlightSelected = true;
                            });
                          },
                          child: ChoiceChip(Icons.flight_takeoff, "Flights",
                              isFlightSelected)),
                      SizedBox(
                        width: 20.0,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              isFlightSelected = false;
                            });
                          },
                          child: ChoiceChip(
                              Icons.hotel, "Hotels", !isFlightSelected))
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  ChoiceChip(this.icon, this.text, this.isSelected);

  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(20.0)))
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.white,
          ),
          SizedBox(width: 8.0),
          Text(
            widget.text,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 16.0,
          ),
          Text('Currently Watched Items', style: dropDownItemStyle),
          Spacer(),
          Text(
            'View All(12)',
            style: viewAllStyle,
          ),
        ],
      ),
    ),
    Container(
      height: 210.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards,
      ),
    ),
  ],
);

List<CityCard> cityCards = [
  CityCard(
      "Las Vegas", "50", "assets/image_04.jpg", "Apr 2019", "2500", "5000"),
  CityCard("Sydney", "50", "assets/image_02.jpg", "Feb 2019", "5000", "10000"),
  CityCard("New York", "10", "assets/image_03.jpg", "May 2019", "4500", "5000"),
  CityCard("Dubai", "80", "assets/image_01.png", "Apr 2018", "2000", "10000"),
];
final formatCurrency = NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  CityCard(this.cityName, this.discount, this.imagePath, this.monthYear,
      this.newPrice, this.oldPrice);
  // const CityCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  width: 160.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 160.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black,
                        ])),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  right: 10.0,
                  top: 15.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "\$ $newPrice",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        " (\$  $oldPrice ) ",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.1)
                        ])),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            cityName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          Text(
                            monthYear,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text("$discount%",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   mainAxisSize: MainAxisSize.max,
          //   children: <Widget>[
          //     SizedBox(width: 5.0,),
          //     Text(newPrice,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
          //     SizedBox(width: 5.0,),
          //     Text(oldPrice,style: TextStyle(color:Colors.grey,fontWeight: FontWeight.normal),),
          //   ],
          // ),
        ],
      ),
    );
  }
}
