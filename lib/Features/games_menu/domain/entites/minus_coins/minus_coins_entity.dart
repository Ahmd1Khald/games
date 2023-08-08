import 'package:equatable/equatable.dart';

class MinusCoinsEntity extends Equatable {
  final String message;

  const MinusCoinsEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
