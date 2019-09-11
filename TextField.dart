// 11 Sep 2019 14:37 Pm 
Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  style: TextStyle(fontFamily: "lora", color: Colors.black),
                  decoration: new InputDecoration(
                    hintText: 'Username',
                    hintStyle:
                        TextStyle(fontFamily: "lora", color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(241, 241, 239, 1.0),
                          width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(241, 241, 239, 1.0),
                          width: 0.0),
                    ),
                    fillColor: Color.fromRGBO(241, 241, 239, 1.0),
                  ),
                  
                ),
              )
