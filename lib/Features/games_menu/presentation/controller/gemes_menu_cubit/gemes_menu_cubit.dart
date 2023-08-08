import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/get_coins/get_coins_entite.dart';
import '../../../domain/usecase/get_list_topics_usecase.dart';

part 'games_menu_state.dart';

class GamesMenuCubit extends Cubit<GamesMenuState> {
  GamesMenuCubit(this.getCoinsUseCase) : super(GamesMenuInitial());

  static GamesMenuCubit get(context) => BlocProvider.of(context);

  GetCoinsEntity? getCoinsData;
  final GetCoinsUseCase getCoinsUseCase;

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
}
