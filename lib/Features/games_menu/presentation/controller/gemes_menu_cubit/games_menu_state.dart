part of 'gemes_menu_cubit.dart';

abstract class GamesMenuState {}

class GamesMenuInitial extends GamesMenuState {}

class GamesMenuLoadingGetCoinsList extends GamesMenuState {}

class GamesMenuSuccessGetCoinsList extends GamesMenuState {
  final List<GetCoinsEntity> data;
  GamesMenuSuccessGetCoinsList(this.data);
}

class GamesMenuErrorGetCoinsList extends GamesMenuState {
  final String error;
  GamesMenuErrorGetCoinsList(this.error);
}
