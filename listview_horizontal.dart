import 'package:flutter/material.dart';

class Vessel extends StatefulWidget {
  Vessel({Key key}) : super(key: key);

  _VesselState createState() => _VesselState();
}

class _VesselState extends State<Vessel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 251, 246, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Clean Nature",
          style: TextStyle(fontFamily: "lora", color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Help Us',
                        style: TextStyle(fontFamily: "lora", fontSize: 40),
                      ),
                      Text(
                        'save planet earth',
                        style: TextStyle(fontFamily: "lora", fontSize: 25),
                      )
                    ],
                  ),
                  // Image.asset("images/leaf.png",height: 100,width: 180,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextField(
                style: TextStyle(fontFamily: "lora", color: Colors.black),
                decoration: new InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(fontFamily: "lora", color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(241, 241, 239, 1.0), width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(241, 241, 239, 1.0), width: 0.0),
                  ),
                  fillColor: Color.fromRGBO(241, 241, 239, 1.0),
                ),
              ),
            ),
            Text(
              'Best sellers',
              style: TextStyle(fontFamily: "lora"),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (c, i) {
                    return SizedBox(
                      width: 20,
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) => Card(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "images/brush${index + 1}.png",
                            height: 150,
                            width: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Bamboo Toothbrush',
                              style:
                                  TextStyle(fontFamily: "lora", fontSize: 25),
                              softWrap: true,
                            ),
                          ),
                          Text(
                            '4,90 \$',
                            style: TextStyle(
                                fontFamily: "lora",
                                color: Color.fromRGBO(144, 194, 169, 1.0),
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'New Product',
              style: TextStyle(fontFamily: "lora"),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (c, i) {
                    return SizedBox(
                      width: 20,
                    );
                  },
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Product(tag:index,image:"images/brush${index + 1}.png" ,)));
                    },
                    child: Card(
                      child: Container(
                        width: 250,
                        child: Row(
                          children: <Widget>[
                            Hero(
                              tag: index,
                              child: Container(
                                height: 100,
                                child: Image.asset(
                                  "images/brush${index + 1}.png",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Wrap(
                                children: <Widget>[
                                  Text(
                                    "Hello Hollywood",
                                    style: TextStyle(
                                        fontFamily: "lora", fontSize: 25),
                                  ),
                                  Text(
                                    '4,90 \$',
                                    style: TextStyle(
                                        fontFamily: "lora",
                                        color:
                                            Color.fromRGBO(144, 194, 169, 1.0),
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product extends StatefulWidget {
  final int tag;
  final String image;
  Product({this.image,this.tag,Key key}) : super(key: key);

  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
       
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130),
            child: Hero(

              tag: widget. tag,
              child: Image.asset(widget.image),
            ),
          )
        ],
      ),
    );
  }
}
