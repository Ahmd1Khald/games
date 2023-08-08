import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/get_coins/get_coins_entite.dart';
import '../../../domain/entites/minus_coins/minus_coins_entity.dart';
import '../../../domain/usecase/get_coins_usecase.dart';
import '../../../domain/usecase/minus_coins_usecase.dart';

part 'games_menu_state.dart';

class GamesMenuCubit extends Cubit<GamesMenuState> {
  GamesMenuCubit(this.getCoinsUseCase, this.minusCoinsUseCase)
      : super(GamesMenuInitial());

  static GamesMenuCubit get(context) => BlocProvider.of(context);

  GetCoinsEntity? getCoinsData;
  MinusCoinsEntity? minusCoinsData;
  final GetCoinsUseCase getCoinsUseCase;
  final MinusCoinsUseCase minusCoinsUseCase;

  Future<void> fetchCoins() async {
    emit(GamesMenuLoadingGetCoinsState());
    var result = await getCoinsUseCase.execute();
    result.fold((failure) {
      emit(GamesMenuErrorGetCoinsState(failure.message));
    }, (data) {
      getCoinsData = data;
      emit(GamesMenuSuccessGetCoinsState(data));
    });
  }

  Future<void> minusCoins({required int count}) async {
    emit(GamesMenuLoadingMinusCoinsState());
    var result = await minusCoinsUseCase.execute(count);
    result.fold((failure) {
      print(failure.message);
      emit(GamesMenuErrorMinusCoinsState(failure.message));
    }, (data) {
      minusCoinsData = data;
      emit(GamesMenuSuccessMinusCoinsState(data));
    });
  }
}
