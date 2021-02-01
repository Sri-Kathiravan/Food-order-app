import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/blocs/index.dart';
import 'package:list/data_model/index.dart';
import 'package:list/data_repo/index.dart';
import 'package:list/helpers/index.dart';
import 'package:list/network/network_manager.dart';
import 'package:list/screens/index.dart';

enum AUTH_EVENT {
  UN_AUTH, SEND_OTP, SENDING_OTP, OTP_SENT, OTP_FAILED, VERIFY_OTP, VERIFING_OTP, SUCCESS, FAILED
}

class AuthState {
  AUTH_EVENT event;
  UserPhNoDm phoneNoDetails;
  AuthData authData;
  String otp;
}

class AuthBloc extends Bloc<AUTH_EVENT, AuthState> {

  AuthState currentState;

  AuthBloc() {
    BlocManager.getInstance().setAuthBloc(this);
  }

  @override
  AuthState get initialState {
    currentState = new AuthState();
    currentState.event = AUTH_EVENT.UN_AUTH;
    return currentState;
  }

  @override
  Stream<AuthState> mapEventToState(AUTH_EVENT event) async* {
    currentState.event = event;

    switch(event) {
      case AUTH_EVENT.UN_AUTH:
        break;

      case AUTH_EVENT.SEND_OTP:
        if(currentState.phoneNoDetails != null && currentState.phoneNoDetails.phoneNumber != null && currentState.phoneNoDetails.phoneNumber.length == 10) {
          add(AUTH_EVENT.SENDING_OTP);
          NetworkManager().sendOtp(currentState.phoneNoDetails.phoneNumber).then((otpResp) {
            if(otpResp != null && otpResp.success != null && otpResp.success == true) {
              add(AUTH_EVENT.OTP_SENT);
            } else {
              add(AUTH_EVENT.OTP_FAILED);
            }
          });
        } else {
          add(AUTH_EVENT.OTP_FAILED);
        }
        break;

      case AUTH_EVENT.SENDING_OTP:
        break;

      case AUTH_EVENT.OTP_SENT:
        getToast("Otp Sent...");
        navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => OtpVerificationScreen()));
        break;

      case AUTH_EVENT.OTP_FAILED:
        getToast("Unable to send otp...");
        break;

      case AUTH_EVENT.VERIFY_OTP:
        if(currentState.otp != null && currentState.otp.length == 6) {
          add(AUTH_EVENT.VERIFING_OTP);
          NetworkManager().verifyOtp(currentState.phoneNoDetails.phoneNumber, currentState.otp).then((response) {
            if(response != null && response.success != null && response.success == true) {
              currentState.authData = response.data;
              add(AUTH_EVENT.SUCCESS);
            } else {
              add(AUTH_EVENT.FAILED);
            }
          });
        } else {
          add(AUTH_EVENT.FAILED);
        }
        break;

      case AUTH_EVENT.VERIFING_OTP:
        break;

      case AUTH_EVENT.SUCCESS:
        getToast("Logged In...");
        navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
        break;

      case AUTH_EVENT.FAILED:
        getToast("Invalid otp");
        break;

    }
    yield _duplicateState(currentState);
  }

  AuthState _duplicateState(AuthState oldState) {
    AuthState newState = new AuthState();
    newState.event = oldState.event;
    newState.phoneNoDetails = oldState.phoneNoDetails;
    newState.authData = oldState.authData;
    newState.otp = oldState.otp;
    return newState;
  }

}