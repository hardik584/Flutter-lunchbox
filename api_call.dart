import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iconflux_restaurant/src/utility/app_pref.dart';
import 'package:iconflux_restaurant/src/utility/constant.dart';
import 'package:iconflux_restaurant/src/utility/utils.dart';
import 'package:iconflux_restaurant/src/utility/validation_message.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

String loginApi = baseURL + 'mobilelogin';
String selectRole = baseURL + 'selectrole';
String userDetails = baseURL + 'getUserDetails';
String checkTokenApi = baseURL + 'generatelogintoken';
String ledgerReport = baseURL + 'GetWaiterLedgerReport';
String getCreditCardType = baseURL + 'getCreditCardType';
String getTenderType = baseURL + 'getTenderType';
String getPaymentRule = baseURL + 'getPaymentRule';
String getCharges = baseURL + 'azalea/v1.0/getcharge';
String getReportEmpList = baseURL + 'getreporttoemployees';
String generateAccessToken = baseURL + 'generateaccesstoken';
String getCustomerList = baseURL + 'getCustomerList';
String ledgerReportPayment = baseURL + 'GetPaymentForWaiterLedgerReport';
String getEarningCode = baseURL + 'getearningcode';
String getPayRate = baseURL + 'getpayrate';
String getPayrollPeriod = baseURL + 'getpayrollperiods';
String getDivision = baseURL + 'getempdivision';
String getDocAction = baseURL + 'getdocaction';
String getTimeZoneList = baseURL + 'gettimezonelist';
String getLastClockIn = baseURL + 'getlastclockin';
String getLastClockInFromWebPunch = baseURL + 'getlastclockinfromwebpunch';
String getDefaultEmpDetails = baseURL + 'getemployeedetails';
String getCreateTimeCardWebPunch = baseURL + 'createtimecardwebpunch';

String listTerminals = cardConnectBaseURL + 'v2/listTerminals';
String cardConnect = cardConnectBaseURL + 'v2/connect';
String readCard = cardConnectBaseURL + 'v2/readCard';
String authCard = cardConnectBaseURL + 'v3/authCard';
String cardConnectTip = cardConnectBaseURL + 'v3/tip';

String storeSignature = cardConnectRestBaseURL + 'sigcap';
String paymentCapture = cardConnectRestBaseURL + 'capture';
String paymentVoid = cardConnectRestBaseURL + 'void';
String inquireByRefNo = cardConnectRestBaseURL + 'inquire';

/// Gift Card
String createGiftCard = baseURL + 'CreateGiftCard';
String getGiftCard = baseURL + 'GetGiftCard';
String addGiftCardBalance = baseURL + 'Add_Gift_Balance_Route';

int accessTokenExpireCode = -102;

abstract class OnAPIResponseHandler {
  onSuccess(String tag, dynamic map);

  onAPIError(String tag);

  onNetworkError(String tag, String msg);

  onChangeProgress(String tag, bool isShow);
}

abstract class OnCardConnectAPIResponseHandler {
  onCardConnectSuccess(String tag, dynamic map);

  onCardConnectAPIError(String tag, int responseCode, dynamic map);

  onCardConnectChangeProgress(String tag, bool isShow);
}

Future doApiCall(
    {@required String url,
      @required Object params,
      @required OnAPIResponseHandler responseHandler}) async {
  try {
    if (await checkInternet()) {
      responseHandler.onChangeProgress(url, true);
      //String token = await getPrefValue<String>(prefLoginToken);
      Map m = {};
      m.addAll(params);
      showLog("URL", url);
      showLog("REQUEST", json.encoder.convert(m));
      //showLog("TOKEN", token);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      /* if (token.isNotEmpty) {
        headers.putIfAbsent('Authorization', () => token);
      }*/
      /* if (requestType == actionPost) {
        response = await http
            .post(url, body: json.encoder.convert(m), headers: headers)
            .timeout(Duration(minutes: 1), onTimeout: () {
          return null;
        });
      } else {
        response =
        await http.get(url).timeout(Duration(minutes: 1), onTimeout: () {
          return null;
        });
      }*/

      var response = await http
          .post(url, body: json.encoder.convert(m), headers: headers)
          .timeout(Duration(minutes: 1), onTimeout: () {
        return null;
      });

      if (response != null) {
        int statusCode = response.statusCode;
        if (statusCode == 200) {
          var result = json.decode(response.body);
          showLog("RESPONSE", json.encoder.convert(result));
          responseHandler.onSuccess(url, json.decode(response.body));
          responseHandler.onChangeProgress(url, false);
        } else if (statusCode == 500) {
          responseHandler.onNetworkError(url, msgInternalServerError);
          responseHandler.onChangeProgress(url, false);
        }
      } else {
        responseHandler.onNetworkError(url, msgSlowConnection);
        responseHandler.onChangeProgress(url, false);
      }
    } else {
      responseHandler.onNetworkError(url, msgNoInternet);
    }
    return null;
  } catch (e) {
    showLog('API_EXCEPTION', e.toString());
    responseHandler.onNetworkError(url, msgNWError);
    responseHandler.onChangeProgress(url, false);
    return null;
  }
}

Future doCardConnectApiCall(
    {@required String url,
      @required Object params,
      @required OnCardConnectAPIResponseHandler responseHandler,
      isRestAPI = false}) async {
  try {
    if (await checkInternet()) {
      responseHandler.onCardConnectChangeProgress(url, true);
      String sessionKey = await getPrefValue<String>(prefCardConnectSessionKey);

      Map m = {};

      if (params != null) {
        m.addAll(params);
      }

      showLog("URL", url);
      showLog("REQUEST", json.encoder.convert(m));
      Map<String, String> headers;
      if (isRestAPI) {
        String username = 'testing';
        String password = 'testing123';
        String authorizationHeader =
            'Basic ' + base64Encode(utf8.encode('$username:$password'));
        headers = {
          'Content-Type': 'application/json',
          'Authorization': authorizationHeader
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'Authorization': 'ZCb8pPkXcZDVO0CIngLSFrBJgA/BYyUZIHT8zaj3MPg=',
          'X-CardConnect-SessionKey': sessionKey == null ? '' : sessionKey
        };
      }
      var response;
      if(params != null){
        response = await http
            .post(url, body: json.encoder.convert(m), headers: headers)
            .timeout(Duration(minutes: 10), onTimeout: () {
          return null;
        });
      }else{
        response = await http.get(url, headers: headers)
            .timeout(Duration(minutes: 10), onTimeout: () {
          return null;
        });
      }

      if (response != null) {
        showLog("RESPONSE", response.body.toString());
        //get all headers
        if (url == cardConnect) {
          Map<String, String> map = response.headers;
//          map.forEach((k, v) => print('${k}: ${v}'));
          if (map['x-cardconnect-sessionkey'] != null) {
            String sessionKey = map['x-cardconnect-sessionkey'];
            if (sessionKey != null && sessionKey.length > 0) {
              int index = sessionKey.indexOf(';');
              String originalSessionKey = '';
              if (index > 0) {
                originalSessionKey = sessionKey.substring(0, index);
              } else {
                originalSessionKey = sessionKey;
              }
              try {
                await setPrefValue<String>(
                    prefCardConnectSessionKey, originalSessionKey);
              } catch (e) {
                print(e);
              }
              print(originalSessionKey);
            }
          }
        }
        int statusCode = response.statusCode;
        if (statusCode == 200) {
          if (response.body != null && response.body.length > 0) {
            responseHandler.onCardConnectSuccess(
                url, json.decode(response.body));
          } else {
            Map map = {};
            responseHandler.onCardConnectSuccess(url, map);
          }
          responseHandler.onCardConnectChangeProgress(url, false);
        } else {
          if (response.body != null && response.body.length > 0) {
            responseHandler.onCardConnectAPIError(
                url, statusCode, response.body.toString());
          } else {
            responseHandler.onCardConnectAPIError(
                url, statusCode, msgInternalServerError);
          }
          responseHandler.onCardConnectChangeProgress(url, false);
        }
      } else if (response.body.length == 0) {
        responseHandler.onCardConnectAPIError(url, 0, msgSomethingWentWrong);
        responseHandler.onCardConnectChangeProgress(url, false);
      } else {
        responseHandler.onCardConnectAPIError(url, 0, msgSlowConnection);
        responseHandler.onCardConnectChangeProgress(url, false);
      }
    } else {
      responseHandler.onCardConnectAPIError(url, 0, msgNoInternet);
    }
    return null;
  } catch (e) {
    showLog('API_EXCEPTION', e.toString());
    responseHandler.onCardConnectAPIError(url, 0, msgNWError);
    responseHandler.onCardConnectChangeProgress(url, false);
    return null;
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:japaclub/utils/app_text.dart';
import 'package:japaclub/utils/utils.dart';
import 'package:http/http.dart' as http;

abstract class OnAPIResponseHandler {
  onSuccess(String tag, dynamic map);

  onAPIError(String tag);

  onNetworkError(String tag, String msg);

  onChangeProgress(String tag, bool isShow);
}

Future doApiCall(
    {@required String url,
    @required Object params,
    @required OnAPIResponseHandler responseHandler}) async {
  try {
    if (await checkinternet()) {
      responseHandler.onChangeProgress(url, true);
      //String token = await getPrefValue<String>(prefLoginToken);
      Map m = {};
      m.addAll(params);
      showLog("URL", url);
      showLog("REQUEST", json.encoder.convert(m));
      //showLog("TOKEN", token);
      Map<String, String> headers = {'Content-Type': 'application/json'};
      /* if (token.isNotEmpty) {
        headers.putIfAbsent('Authorization', () => token);
      }*/
      /* if (requestType == actionPost) {
        response = await http
            .post(url, body: json.encoder.convert(m), headers: headers)
            .timeout(Duration(minutes: 1), onTimeout: () {
          return null;
        });
      } else {
        response =
        await http.get(url).timeout(Duration(minutes: 1), onTimeout: () {
          return null;
        });
      }*/

      var response = await http
          .post(url, body: json.encoder.convert(m), headers: headers)
          .timeout(Duration(minutes: 1), onTimeout: () {
        return null;
      });

      if (response != null) {
        int statusCode = response.statusCode;
        if (statusCode == 200) {
          var result = json.decode(response.body);
          showLog("RESPONSE", json.encoder.convert(result));
          responseHandler.onSuccess(url, json.decode(response.body));
          responseHandler.onChangeProgress(url, false);
        } else if (statusCode == 500) {
          responseHandler.onNetworkError(url, msgInternalServerError);
          responseHandler.onChangeProgress(url, false);
        }
      } else {
        responseHandler.onNetworkError(url, msgSlowConnection);
        responseHandler.onChangeProgress(url, false);
      }
    } else {
      responseHandler.onNetworkError(url, msgNoInternet);
    }
    return null;
  } catch (e) {
    showLog('API_EXCEPTION', e.toString());
    responseHandler.onNetworkError(url, msgNWError);
    responseHandler.onChangeProgress(url, false);
    return null;
  }
