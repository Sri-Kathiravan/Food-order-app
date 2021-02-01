import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/blocs/bloc_manager.dart';
import 'package:list/blocs/home_bloc.dart';
import 'package:list/blocs/index.dart';
import 'package:list/data_model/index.dart';
import 'package:list/helpers/index.dart';
import 'package:list/network/network_manager.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => BlocManager.getInstance().getHomeBloc(),
      child: _HomeScreenStateful(),
    );
  }

}

class _HomeScreenStateful extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<_HomeScreenStateful> {

  bool _isDeviceLocationON = false;
  LocationDm _home, _work, _selectedLocation;
  
  @override
  void initState() {
    super.initState();
    _home = new LocationDm(17.459719, 78.367622, "Home", "47W, 17th st, New York, NY 10011, USA", Icons.home);
    _work = new LocationDm(13.041241, 80.2521276, "Work", "47W, 17th st, New York, NY 10011, USA", Icons.location_city);
    _selectedLocation = new LocationDm(13.041241, 80.2521276, "Location", "Add location to continue", Icons.home);
  }

  @override
  Widget build(BuildContext context) {

    getSelectedLocation();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width,
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
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.04,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _showLocationBottomSheet(() {
                                  setState(() {
                                    getSelectedLocation();
                                  });
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width * 0.04,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width * 0.08,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width * 0.02,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            alignment: AlignmentDirectional.topStart,
                                            child: Text(
                                              "${_selectedLocation.name}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "QuicksandBold",
                                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            alignment: AlignmentDirectional.topStart,
                                            margin: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.width * 0.01,
                                            ),
                                            child: Text(
                                              "${_selectedLocation.address}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
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
                                  ],
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              _showLogoutBottomSheet();
                            },
                            child: Container(
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.08,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04,
                        bottom: MediaQuery.of(context).size.width * 0.05,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.02)),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Color(0xffDF2A32),
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            Expanded(
                              child: Container(
                                alignment: AlignmentDirectional.centerStart,
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.02,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "QuicksandBold",
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "What are you craving for?",
                                    hintStyle: TextStyle(
                                      color: Colors.black38,
                                      fontFamily: "QuicksandBold",
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),

            Expanded(
              child: Container(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (BuildContext context, HomeState homeState) {

                    if(homeState.event == HOME_EVENT.UNKNOWN_LOCATION) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        _showLocationBottomSheet(() {
                          setState(() {
                            getSelectedLocation();
                          });
                        });
                      });
                      return buildTextMessage(context, "Enter Address to continue");
                    } else if(homeState.event == HOME_EVENT.GETTING_PRODUCTS) {
                      return buildLoadingWidget(context, "Getting products");
                    } else if(homeState.event == HOME_EVENT.LOGGING_OUT) {
                      return buildLoadingWidget(context, "Logging out");
                    } else {

                      if(homeState.product != null && homeState.product.success != null && homeState.product.success) {
                        return _buildProducts(homeState.product);
                      } else {
                        return buildTextMessage(context, "Sorry, we can't deliver to selected location.");
                      }

                    }

                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildProducts(ProductDm product) {
    return ListView.builder(
        itemBuilder: (context, position) {
          return _buildIndividualProduct(product.data.products[position]);
        },
      itemCount: product.data.products.length,
        );
  }

  _buildIndividualProduct(Product product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.04,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
          ),
          alignment: AlignmentDirectional.topStart,
          child: Text(
            "${product.name}",
            style: TextStyle(
              color: Colors.black87,
              fontFamily: "QuicksandBold",
              fontSize: MediaQuery.of(context).size.width * 0.045,
            ),
          ),
        ),
        (product.productVariants != null)
            ? ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (context, position) {
            return _buildVarient(product.productVariants[position], position);
            },
          itemCount: product.productVariants.length,
        )
            : Container(),
      ],
    );
  }

  Widget _buildVarient(ProductVariant variant, int position) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.04,
        left: MediaQuery.of(context).size.width * 0.04,
        right: MediaQuery.of(context).size.width * 0.04,
        bottom: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildImage(position),
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red[200],
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Text(
                      " BEST SELLER ",
                      style: TextStyle(
                        color: Colors.red[200],
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Text(
                      "${variant.name}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Net Wt: ${variant.unitValue} kg",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "QuicksandSemiBold",
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "₹ ${variant.maximumRetailPrice}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "QuicksandBold",
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildImage(int pos) {
    String imageUrl;
    if(pos % 2 == 0) {
      imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4LOQCjEQkhBfM215Z6TQhqBwZa2ojEz-ztA&usqp=CAU";
    } else {
      imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZDTW3pH55CxPcsv5zgnf1CVFvMUl5F-BQGQ&usqp=CAU";
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imageUrl,
        height: MediaQuery.of(context).size.width * 0.28,
        width: MediaQuery.of(context).size.width * 0.25,
        fit: BoxFit.fill,
      ),
    );
  }

  _showLocationBottomSheet(Function() refresh) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
        ),
        isScrollControlled: true,
        elevation: 2,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffDF2A32),
                        borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(MediaQuery.of(context).size.width * 0.04),
                          topRight:
                          Radius.circular(MediaQuery.of(context).size.width * 0.04),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.04,
                                right: MediaQuery.of(context).size.width * 0.04,
                                bottom: MediaQuery.of(context).size.width * 0.04,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(
                                              "Device Location",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "QuicksandBold",
                                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                              ),
                                            ),
                                          ),

                                          Container(
                                            alignment: AlignmentDirectional.topStart,
                                            margin: EdgeInsets.only(
                                              top: MediaQuery.of(context).size.width * 0.02,
                                            ),
                                            child: Text(
                                              "For accurate address and hussle free delivery use device location",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
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
                                  ),
                                  CupertinoSwitch(
                                    value: _isDeviceLocationON,
                                    activeColor: Colors.white70,
                                    onChanged: (selectedBool) {
                                      setState(() {
                                        _isDeviceLocationON = selectedBool;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.width * 0.03,
                                    left: MediaQuery.of(context).size.width * 0.04,
                                    right: MediaQuery.of(context).size.width * 0.04,
                                    bottom: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[

                                      Container(
                                        alignment: AlignmentDirectional.centerStart,
                                        child: Text(
                                          "Saved Address",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "QuicksandBold",
                                            fontSize: MediaQuery.of(context).size.width * 0.045,
                                          ),
                                        ),
                                      ),

                                      buildLocationUI(context, _home, () {
                                        refresh();
                                        Navigator.pop(context);
                                        setState(() {
                                          BlocManager.getInstance().getHomeBloc().currentState.selectedLocation = _home;
                                          BlocManager.getInstance().getHomeBloc().add(HOME_EVENT.GET_PRODUCTS);
                                        });
                                      }),

                                      buildLocationUI(context, _work, () {
                                        refresh();
                                        Navigator.pop(context);
                                        setState(() {
                                          BlocManager.getInstance().getHomeBloc().currentState.selectedLocation = _work;
                                          BlocManager.getInstance().getHomeBloc().add(HOME_EVENT.GET_PRODUCTS);
                                        });
                                      }),

                                      Expanded(child: Container())

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
    );
  }

  _showLogoutBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
        ),
        isScrollControlled: true,
        elevation: 2,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                      Radius.circular(MediaQuery.of(context).size.width * 0.04),
                      topRight:
                      Radius.circular(MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.03,
                          left: MediaQuery.of(context).size.width * 0.04,
                          right: MediaQuery.of(context).size.width * 0.04,
                        ),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Color(0xffDF2A32),
                            fontFamily: "QuicksandBold",
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                      ),

                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.03,
                          left: MediaQuery.of(context).size.width * 0.04,
                          right: MediaQuery.of(context).size.width * 0.04,
                          bottom: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Text(
                          "Are you sure you want to logout?",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "QuicksandSemiBold",
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: MediaQuery.of(context).size.width * 0.08,
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "QuicksandBold",
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    BlocManager.getInstance().getHomeBloc().add(HOME_EVENT.LOGOUT);
                                  },
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    height: MediaQuery.of(context).size.width * 0.08,
                                    child: Text(
                                      "CONFIRM",
                                      style: TextStyle(
                                        color: Color(0xffDF2A32),
                                        fontFamily: "QuicksandBold",
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
    );
  }

  void getSelectedLocation() {
    if(BlocManager.getInstance().getHomeBloc().currentState != null
        && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation != null
        && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation.name == _home.name) {
      _selectedLocation = _home;
    } else if(BlocManager.getInstance().getHomeBloc().currentState != null
        && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation != null
        && BlocManager.getInstance().getHomeBloc().currentState.selectedLocation.name == _work.name) {
      _selectedLocation = _work;
    }
  }

}