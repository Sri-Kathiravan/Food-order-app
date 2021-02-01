import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/blocs/index.dart';
import 'package:list/helpers/index.dart';
import 'package:list/screens/index.dart';

class OtpVerificationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => BlocManager.getInstance().getAuthBloc(),
      child: _OtpVerificationStateful(),
    );
  }

}

class _OtpVerificationStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _OtpVerificationState();
  }

}

class _OtpVerificationState extends State<_OtpVerificationStateful> {

  Timer _timer;
  int _remainingTime = 60;
  TextEditingController _otp1, _otp2, _otp3, _otp4, _otp5, _otp6;
  FocusNode _focusNode1, _focusNode2, _focusNode3, _focusNode4, _focusNode5, _focusNode6;

  @override
  void initState() {
    super.initState();
    _otp1 = new TextEditingController();
    _otp2 = new TextEditingController();
    _otp3 = new TextEditingController();
    _otp4 = new TextEditingController();
    _otp5 = new TextEditingController();
    _otp6 = new TextEditingController();

    _focusNode1 = new FocusNode();
    _focusNode2 = new FocusNode();
    _focusNode3 = new FocusNode();
    _focusNode4 = new FocusNode();
    _focusNode5 = new FocusNode();
    _focusNode6 = new FocusNode();
    startTimer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: buildLoginTopWidget(context, "Verify Phone No.", "Please enter otp sent to +91 ${BlocManager.getInstance().getAuthBloc().currentState.phoneNoDetails.phoneNumber}", () {
                Navigator.pop(context);
              }),
            ),

            Expanded(
              flex: 4,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState authState) {

                  if(authState.event == AUTH_EVENT.VERIFING_OTP) {
                    return buildLoadingWidget(context, "Logging In");
                  } else {
                    return Container(
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.04,
                              left: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Text(
                              "ENTER OTP",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "QuicksandBold",
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.04,
                              left: MediaQuery.of(context).size.width * 0.04,
                              right: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                buildOtpBox(context, _otp1, _focusNode1, TextInputAction.next, (otpText) {
                                  if(_otp1.text.length == 1){
                                    _fieldFocusChange(context, _focusNode1, _focusNode2);
                                  }
                                }),

                                buildOtpBox(context, _otp2, _focusNode2, TextInputAction.next, (otpText) {
                                  if(_otp2.text.length == 1){
                                    _fieldFocusChange(context, _focusNode2, _focusNode3);
                                  }
                                }),

                                buildOtpBox(context, _otp3, _focusNode3, TextInputAction.next, (otpText) {
                                  if(_otp3.text.length == 1){
                                    _fieldFocusChange(context, _focusNode3, _focusNode4);
                                  }
                                }),

                                buildOtpBox(context, _otp4, _focusNode4, TextInputAction.next, (otpText) {
                                  if(_otp4.text.length == 1){
                                    _fieldFocusChange(context, _focusNode4, _focusNode5);
                                  }
                                }),

                                buildOtpBox(context, _otp5, _focusNode5, TextInputAction.next, (otpText) {
                                  if(_otp5.text.length == 1){
                                    _fieldFocusChange(context, _focusNode5, _focusNode6);
                                  }
                                }),

                                buildOtpBox(context, _otp6, _focusNode6, TextInputAction.done, (otpText) {
                                  if(_otp6.text.length == 1){

                                  }
                                }),

                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.02,
                              left: MediaQuery.of(context).size.width * 0.04,
                              right: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[

                                Expanded(
                                  child: (_remainingTime == 0) ? Text(
                                    "Didn't received OTP.",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "QuicksandBold",
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                    ),
                                  ) : Container(),
                                ),

                                (_remainingTime == 0)
                                    ? InkWell(
                                  onTap: () {

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.refresh,
                                        size: MediaQuery.of(context).size.width * 0.04,
                                        color: Color(0xffDF2A32),
                                      ),
                                      Text(
                                        "  RESEND",
                                        style: TextStyle(
                                          color: Color(0xffDF2A32),
                                          fontFamily: "QuicksandBold",
                                          fontSize: MediaQuery.of(context).size.width * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),)
                                    : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.timelapse,
                                      size: MediaQuery.of(context).size.width * 0.04,
                                      color: Colors.black54,
                                    ),
                                    Text(
                                      " $_remainingTime sec left",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "QuicksandBold",
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.06,
                              left: MediaQuery.of(context).size.width * 0.04,
                              right: MediaQuery.of(context).size.width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                              color: Color(0xffDF2A32),
                            ),
                            child: InkWell(
                              onTap: () {
                                if(validateOtpLocal()) {
                                  String otpStr = "" + _otp1.text + _otp2.text + _otp3.text + _otp4.text + _otp5.text + _otp6.text;
                                  BlocManager.getInstance().getAuthBloc().currentState.otp = otpStr;
                                  BlocManager.getInstance().getAuthBloc().add(AUTH_EVENT.VERIFY_OTP);
                                } else {
                                  getToast("Please enter a valid otp");
                                }
                              },
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  "VERIFY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "QuicksandBold",
                                    fontSize: MediaQuery.of(context).size.width * 0.045,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    );
                  }

                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  bool validateOtpLocal() {
    if(_otp1.text != null && _otp1.text != ""
        && _otp2.text != null && _otp2.text != ""
        && _otp3.text != null && _otp3.text != ""
        && _otp4.text != null && _otp4.text != ""
        && _otp5.text != null && _otp5.text != ""
        && _otp6.text != null && _otp6.text != "") {
      return true;
    } else {
      return false;
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic( oneSec, (Timer timer) =>
        setState( () {
          if (_remainingTime < 1) {
            _timer.cancel();
          } else {
            _remainingTime = _remainingTime - 1;
          }
        },
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(_timer != null) {
      _timer.cancel();
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}