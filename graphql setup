import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static String YOUR_PERSONAL_ACCESS_TOKEN =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlNWNlZDZlNDBkY2QxZWZmNDA3MDQ4ODY3YjFlZDFlNzA2Njg2YTAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vamFwYWNsdWItZGV2IiwiYXVkIjoiamFwYWNsdWItZGV2IiwiYXV0aF90aW1lIjoxNTc3NDQ0Nzk0LCJ1c2VyX2lkIjoiRnB4VlNKcXdvUVU4ZXdkRjQzbVl3Nk5nazFSMiIsInN1YiI6IkZweFZTSnF3b1FVOGV3ZEY0M21ZdzZOZ2sxUjIiLCJpYXQiOjE1Nzc0NDQ3OTQsImV4cCI6MTU3NzQ0ODM5NCwicGhvbmVfbnVtYmVyIjoiKzkxODIzODI3ODE5NiIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzkxODIzODI3ODE5NiJdfSwic2lnbl9pbl9wcm92aWRlciI6InBob25lIn19.A1hfnXwR8StrKeFA7viERbkAolQF45niVn_oY36h9DQh3-2SpPr_bk9N6DIZXEesdmRbZ04Z57Al_rv5JOFZvAGABbzjbZBH3YmpnO2DNEHaAmbw7uv4PbX1gdG46p84vwXm6OBDMEEm793w1BhaE5X3KFAM23x04RsMH4zGAxOugyCyzXy9a3tUSaDJSNR_KYFTYoNUSsGCwpG8xf08tr_TbRKzb6KdRIykzQDUwcmYyoTM4Ez524Pba0M3wjd6n-g6rUvjchltVsm9iBDfMf4bS99q10yazkFs3-z3mEvvbhc317TbV9Glb3xH9bUmN2_Wb-ILXp81eyV4nS4D7Q";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    fireGraphQ();
  }

  static final HttpLink _httpLink = HttpLink(
    uri: 'http://192.168.196.32:8090/graphql',
  );

  static final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  );

  static final Link _link = _authLink.concat(_httpLink);

  final GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
  static const String readRepositories = r'''
  query {
  getProfile {
    name,
    email,
    reminder_interval,
    user_id,
    city,
    mobile
    avatar
    
  }
}
''';
  static const int nRepositories = 50;

  final QueryOptions options = QueryOptions(
    document: readRepositories,
    variables: <String, dynamic>{
      'nRepositories': nRepositories,
    },
  );
  fireGraphQ() async {
    final QueryResult result = await _client.query(options);

    if (result.hasErrors) {
      print(result.errors);
    }
    print(result.loading);
    print(result.data);

    // final List<dynamic> repositories =
    //     result.data['viewer']['repositories']['nodes'] as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
