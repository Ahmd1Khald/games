part of 'gemes_menu_cubit.dart';

abstract class GamesMenuState {}

class GamesMenuInitial extends GamesMenuState {}

class GamesMenuLoadingGetCoinsState extends GamesMenuState {}

class GamesMenuSuccessGetCoinsState extends GamesMenuState {
  final GetCoinsEntity data;
  GamesMenuSuccessGetCoinsState(this.data);
}

class GamesMenuErrorGetCoinsState extends GamesMenuState {
  final String error;
  GamesMenuErrorGetCoinsState(this.error);
}

class GamesMenuLoadingMinusCoinsState extends GamesMenuState {}

class GamesMenuSuccessMinusCoinsState extends GamesMenuState {
  final MinusCoinsEntity data;
  GamesMenuSuccessMinusCoinsState(this.data);
}

class GamesMenuErrorMinusCoinsState extends GamesMenuState {
  final String error;
  GamesMenuErrorMinusCoinsState(this.error);
}
