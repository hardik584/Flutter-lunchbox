import 'package:graphql/client.dart';
Future doGraphQLAPICall(
    {String httpURL, String token, String queryData, int length}) async {
////////////////////////////////////////////////////////////////////////////////////////
  Documentation
//  String graphUrl = "http://japaclub.iconflux.info/graphql";

//   String readRepositories = r'''
//   query {
//   getProfile {
//     name,
//     email,
//     reminder_interval,
//     user_id,
//     city,
//     mobile
//     avatar
    
//   }
// }
// ''';
//   int nRepositories = 50;
//   String token =
//       "eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlNWNlZDZlNDBkY2QxZWZmNDA3MDQ4ODY3YjFlZDFlNzA2Njg2YTAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vamFwYWNsdWItZGV2IiwiYXVkIjoiamFwYWNsdWItZGV2IiwiYXV0aF90aW1lIjoxNTc3NDQ0Nzk0LCJ1c2VyX2lkIjoiRnB4VlNKcXdvUVU4ZXdkRjQzbVl3Nk5nazFSMiIsInN1YiI6IkZweFZTSnF3b1FVOGV3ZEY0M21ZdzZOZ2sxUjIiLCJpYXQiOjE1Nzc0NDQ3OTQsImV4cCI6MTU3NzQ0ODM5NCwicGhvbmVfbnVtYmVyIjoiKzkxODIzODI3ODE5NiIsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsicGhvbmUiOlsiKzkxODIzODI3ODE5NiJdfSwic2lnbl9pbl9wcm92aWRlciI6InBob25lIn19.A1hfnXwR8StrKeFA7viERbkAolQF45niVn_oY36h9DQh3-2SpPr_bk9N6DIZXEesdmRbZ04Z57Al_rv5JOFZvAGABbzjbZBH3YmpnO2DNEHaAmbw7uv4PbX1gdG46p84vwXm6OBDMEEm793w1BhaE5X3KFAM23x04RsMH4zGAxOugyCyzXy9a3tUSaDJSNR_KYFTYoNUSsGCwpG8xf08tr_TbRKzb6KdRIykzQDUwcmYyoTM4Ez524Pba0M3wjd6n-g6rUvjchltVsm9iBDfMf4bS99q10yazkFs3-z3mEvvbhc317TbV9Glb3xH9bUmN2_Wb-ILXp81eyV4nS4D7Q";
//  doGraphQLAPICall(
//             httpURL: graphUrl,
//             length: 50,
//             queryData: readRepositories,
//             token: token)
//         .then((onValue) {
//       print(onValue);
//     });
 ////////////////////////////////////////////////////////////////////////////////////////////////////////   
  final HttpLink _httpLink = HttpLink(
    uri: httpURL,
  );
  final AuthLink _authLink = AuthLink(
    getToken: () async => 'Bearer $token',
  );
  final Link _link = _authLink.concat(_httpLink);
  final GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
  final String readRepositories = queryData;
  final int nRepositories = length;
  final QueryOptions options = QueryOptions(
    document: readRepositories,
    variables: <String, dynamic>{
      'nRepositories': nRepositories,
    },
  );
  final QueryResult result = await _client.query(options);

  if (result.hasErrors) {
    print(result.errors);
    return result.errors;
  } else {
    return result.data;
  }
}
