import '../../domain/entites/minus_coins/minus_coins_entity.dart';

class MinusCoinsModel extends MinusCoinsEntity {
  const MinusCoinsModel({
    required super.message,
  });

  factory MinusCoinsModel.fromJson(Map<String, dynamic> json) =>
      MinusCoinsModel(
        message: json['message'],
      );
}
