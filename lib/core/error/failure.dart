abstract class Failure {
  /// ignore: avoid_unused_constructor_parameters
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final String? message;
  final dynamic error;
  final int? statusCode;

  const ServerFailure(
    this.message, {
    this.error,
    this.statusCode,
  });

  @override
  bool operator ==(Object other) =>
      other is ServerFailure &&
      other.message == message &&
      other.error == error &&
      other.statusCode == statusCode;

  @override
  int get hashCode => Object.hash(message, error, statusCode);
}

class NoDataFailure extends Failure {
  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => 0;
}

class CacheFailure extends Failure {
  @override
  bool operator ==(Object other) => other is CacheFailure;

  @override
  int get hashCode => 0;
}

class UnauthorizedFailure extends Failure {
  final String? message;

  const UnauthorizedFailure(this.message);

  @override
  bool operator ==(Object other) =>
      other is UnauthorizedFailure && other.message == message;

  @override
  int get hashCode => message.hashCode;
}
