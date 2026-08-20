import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Unable to connect to the server."]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = "Internal storage error."]);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = "Data parsing error."]);
}
