import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/get_coins/get_coins_entite.dart';
import '../../../domain/usecase/get_list_topics_usecase.dart';

part 'games_menu_state.dart';

class GamesMenuCubit extends Cubit<GamesMenuState> {
  GamesMenuCubit(this.getCoinsUseCase) : super(GamesMenuInitial());

  static GamesMenuCubit get(context) => BlocProvider.of(context);

  List<GetCoinsEntity>? topicsData;
  final GetCoinsUseCase getCoinsUseCase;

  Future<void> fetchGetCoinsList() async {
    emit(GamesMenuLoadingGetCoinsList());
    var result = await getCoinsUseCase.execute();
    result.fold((failure) {
      emit(GamesMenuErrorGetCoinsList(failure.message));
    }, (topics) {
      topicsData = topics;
      emit(GamesMenuSuccessGetCoinsList(topics));
    });
  }
}
