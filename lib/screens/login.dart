import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/blocs/index.dart';
import 'package:list/data_model/data_model.dart';
import 'package:list/helpers/index.dart';
import 'package:list/screens/otp_verification.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => BlocManager.getInstance().getAuthBloc(),
      child: _LoginScreenStateful(),
    );
  }

}

class _LoginScreenStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<_LoginScreenStateful> {

  TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = new TextEditingController();
    BlocManager.getInstance().getAuthBloc();
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
              child: buildLoginTopWidget(context, "Login", "Please enter your phone number to continue", () {

              }),
            ),

            Expanded(
              flex: 4,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState authState) {
                  if(authState.event == AUTH_EVENT.SENDING_OTP) {
                    return buildLoadingWidget(context, "Sending otp");
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
                              "PHONE NUMBER",
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
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black54,
                                        width: 1,
                                      )
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.03
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "+91",
                                          style: TextStyle(
                                            color: Color(0xffDF2A32),
                                            fontFamily: "QuicksandBold",
                                            fontSize: MediaQuery.of(context).size.width * 0.04,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Color(0xffDF2A32),
                                          size: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black54,
                                          width: 1,
                                        )
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width * 0.02,
                                          right: MediaQuery.of(context).size.width * 0.02
                                      ),
                                      child: TextField(
                                        controller: _phoneNumberController,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "QuicksandBold",
                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
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
                                if(_phoneNumberController.text != null && _phoneNumberController.text.length == 10) {
                                  BlocManager.getInstance().getAuthBloc().currentState.phoneNoDetails = new UserPhNoDm(phoneNumber: _phoneNumberController.text, countryCode: "91");
                                  BlocManager.getInstance().getAuthBloc().add(AUTH_EVENT.SEND_OTP);
                                } else {
                                  getToast("Please enter a valid phone number");
                                }
                              },
                              child: Container(
                                alignment: AlignmentDirectional.center,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  "CONTINUE",
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



}