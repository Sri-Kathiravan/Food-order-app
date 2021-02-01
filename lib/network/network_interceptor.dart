import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:list/blocs/bloc_manager.dart';
import 'package:list/data_repo/index.dart';
import 'package:list/helpers/index.dart';
import 'package:list/screens/login.dart';

class NetworkInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    String authToken = "";
    if(BlocManager.getInstance().getAuthBloc().currentState != null
        && BlocManager.getInstance().getAuthBloc().currentState.authData != null
        && BlocManager.getInstance().getAuthBloc().currentState.authData.authToken != null) {
      authToken = BlocManager.getInstance().getAuthBloc().currentState.authData.authToken;
    }
    data.headers["Authorization"] = "$authToken";
    data.headers["Content-Type"] = "application/json";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if(data.statusCode == 401) {
      forceClose();
    }
    return data;
  }
}

void forceClose() {
  getToast("Your session has expired. Please Login again.");
  navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
}