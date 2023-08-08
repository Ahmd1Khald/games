import '../../domain/entites/get_coins/get_coins_entite.dart';

class GetCoinsModel extends GetCoinsEntity {
  const GetCoinsModel({
    required super.coins,
    required super.gems,
  });

  factory GetCoinsModel.fromJson(Map<String, dynamic> json) => GetCoinsModel(
        coins: json['coins'],
        gems: json['gems'],
      );
}
