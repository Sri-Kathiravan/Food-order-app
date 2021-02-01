import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list/blocs/index.dart';
import 'package:list/data_model/index.dart';
import 'package:list/data_repo/index.dart';
import 'package:list/helpers/index.dart';
import 'package:list/network/network_manager.dart';
import 'package:list/screens/index.dart';

enum HOME_EVENT {
  UNKNOWN_LOCATION, GET_PRODUCTS, GETTING_PRODUCTS, REFRESH_PRDUCTS, LOGOUT, LOGGING_OUT, LOGOUT_SUCCESS, LOGOUT_FAILED
}

class HomeState {
  HOME_EVENT event;
  LocationDm selectedLocation;
  ProductDm product;
}

class HomeBloc extends Bloc<HOME_EVENT, HomeState> {

  HomeState currentState;

  HomeBloc() {
    BlocManager.getInstance().setHomeBloc(this);
  }

  @override
  HomeState get initialState {
    currentState = new HomeState();
    currentState.event = HOME_EVENT.UNKNOWN_LOCATION;
    return currentState;
  }

  @override
  Stream<HomeState> mapEventToState(HOME_EVENT event) async* {
    currentState.event = event;

    switch(event) {

      case HOME_EVENT.UNKNOWN_LOCATION:
        break;

      case HOME_EVENT.GET_PRODUCTS:
        add(HOME_EVENT.GETTING_PRODUCTS);
        NetworkManager().getProducts(currentState.selectedLocation.lat, currentState.selectedLocation.lng).then((data) {
          if(data != null) {
            print('PRODUCTS - ${productDmToJson(data)}');
          } else {
            print('PRODUCTS - NULL');
          }
          currentState.product = data;
          add(HOME_EVENT.REFRESH_PRDUCTS);
        });
        break;

      case HOME_EVENT.GETTING_PRODUCTS:
        break;

      case HOME_EVENT.REFRESH_PRDUCTS:
        break;

      case HOME_EVENT.LOGOUT:
        add(HOME_EVENT.LOGGING_OUT);
        NetworkManager().logout().then((isSuccess) {
          if(isSuccess) {
            add(HOME_EVENT.LOGOUT_SUCCESS);
          } else {
            add(HOME_EVENT.LOGOUT_FAILED);
          }

        });
        break;

      case HOME_EVENT.LOGGING_OUT:
        break;

      case HOME_EVENT.LOGOUT_SUCCESS:
        getToast("Logged out...");
        BlocManager.getInstance().logout();
        navigatorKey.currentState.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
        break;
      case HOME_EVENT.LOGOUT_FAILED:
        getToast("Unable to logout");
        add(HOME_EVENT.REFRESH_PRDUCTS);
        break;
    }
    yield _duplicateState(currentState);
  }

  HomeState _duplicateState(HomeState oldState) {
    HomeState newState = new HomeState();
    newState.event = oldState.event;
    newState.selectedLocation = oldState.selectedLocation;
    newState.product = oldState.product;
    return newState;
  }

}