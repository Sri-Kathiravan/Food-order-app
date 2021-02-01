import 'package:list/blocs/index.dart';

class BlocManager {

  static BlocManager _instance;
  AuthBloc _authBloc;
  HomeBloc _homeBloc;

  static BlocManager getInstance() {
    if(_instance == null) {
      _instance = new BlocManager();
    }
    return _instance;
  }

  AuthBloc getAuthBloc() {
    if(_authBloc == null) {
      _authBloc = new AuthBloc();
    }
    return _authBloc;
  }

  void setAuthBloc(AuthBloc bloc) {
    _authBloc = bloc;
  }

  HomeBloc getHomeBloc() {
    if(_homeBloc == null) {
      _homeBloc = new HomeBloc();
    }
    return _homeBloc;
  }

  void setHomeBloc(HomeBloc bloc) {
    _homeBloc = bloc;
  }

  void logout() {
    _instance = null;
    _authBloc = null;
  }
}