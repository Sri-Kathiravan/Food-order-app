import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:list/blocs/bloc_manager.dart';
import 'package:list/data_model/data_model.dart';

Widget buildLoginTopWidget(BuildContext context, String title, String subTitle, Function() onBackPressed) {
  return Container(
    width: MediaQuery.of(context).size.width,
    alignment: AlignmentDirectional.topStart,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffF3444C),
            Color(0xffDF2A32),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
    ),
    child: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.04,
              left: MediaQuery.of(context).size.width * 0.04,
            ),
            width: MediaQuery.of(context).size.width * 0.06,
            height: MediaQuery.of(context).size.width * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10000),
            ),
            child: InkWell(
              onTap: () {
                onBackPressed();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffDF2A32),
                size: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.04,
              left: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Text(
              "$title",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "QuicksandBold",
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.01,
              left: MediaQuery.of(context).size.width * 0.04,
            ),
            child: Text(
              "$subTitle",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                fontFamily: "QuicksandSemiBold",
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),
          ),

        ],
      ),
    ),
  );
}

buildOtpBox(BuildContext context, TextEditingController controller, FocusNode focusNode, TextInputAction inputAction, Function(String text) onChanged) {
  return Container(
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
      width: MediaQuery.of(context).size.width * 0.08,
      alignment: AlignmentDirectional.center,
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        focusNode: focusNode,
        textInputAction: inputAction,
        maxLength: 1,
        onChanged: (text) {
          onChanged(text);
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: "QuicksandBold",
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          counter: Offstage(),
        ),

      ),
    ),
  );
}

Widget buildLocationUI(BuildContext context, LocationDm data, Function() onTap) {

  bool isSelected = false;

  if(BlocManager.getInstance().getHomeBloc().currentState != null
      && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation != null
      && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation.name == data.name) {
    isSelected = true;
  }

  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.04,
        bottom: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            data.iconData,
            color: (isSelected) ? Colors.black87 : Colors.black45,
            size: MediaQuery.of(context).size.width * 0.08,
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.03,
                right: MediaQuery.of(context).size.width * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "${data.name}",
                      style: TextStyle(
                        color: (isSelected) ? Colors.black87 : Colors.black45,
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.005,
                    ),
                    child: Text(
                      "${data.address}",
                      style: TextStyle(
                        color: (isSelected) ? Colors.black54 : Colors.black38,
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),

          Icon(
            (isSelected) ? Icons.check_circle_outline : Icons.more_vert,
            color: (isSelected) ? Color(0xffDF2A32) : Colors.black38,
            size: MediaQuery.of(context).size.width * 0.07,
          ),
        ],
      ),
    ),
  );

}

Future<bool> getToast(String str) {
  return Fluttertoast.showToast(
      msg: str,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 15);
}

Widget buildLoadingWidget(BuildContext context, String note) {
  return Container(
    alignment: AlignmentDirectional.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(),
        Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.02,
          ),
          child: Text(
            "$note...",
            style: TextStyle(
              color: Colors.black54,
              fontFamily: "QuicksandSemiBold",
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextMessage(BuildContext context, String text) {
  return Container(
    alignment: AlignmentDirectional.center,
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.04,
      right: MediaQuery.of(context).size.width * 0.04,
    ),
    child: Text(
      "$text",
      style: TextStyle(
        color: Colors.black54,
        fontFamily: "QuicksandSemiBold",
        fontSize: MediaQuery.of(context).size.width * 0.04,
      ),
    ),
  );
}