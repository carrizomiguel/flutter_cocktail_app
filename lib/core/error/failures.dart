import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({
    this.caption,
  });

  final String? caption;

  @override
  List<Object?> get props => [caption];
}

class BadRequestFailure extends Failure {}

class ConnectionFailure extends Failure {}
