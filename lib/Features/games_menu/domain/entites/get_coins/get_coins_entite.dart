import 'package:equatable/equatable.dart';

class GetCoinsEntity extends Equatable {
  final int coins;
  final int gems;

  const GetCoinsEntity({
    required this.coins,
    required this.gems,
  });

  @override
  List<Object?> get props => [coins, gems];
}
