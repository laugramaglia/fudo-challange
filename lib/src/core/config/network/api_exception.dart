class ApiException implements Exception {
  final String message;
  final String code;
  final String? identifier;

  ApiException({required this.message, required this.code, this.identifier});

  @override
  String toString() {
    return "$code: $message";
  }
}

class NoConnectionException extends ApiException {
  NoConnectionException([String? message])
      : super(
            message: message ?? 'No Internet Connection',
            code: 'no_connection');
}

class TimeOutException extends ApiException {
  TimeOutException([String? message])
      : super(message: message ?? 'No Internet Connection', code: 'time_out');
}

class UnknownException extends ApiException {
  UnknownException({String? message})
      : super(
          message: message ??
              "Unexpected error! Please connect our support services.",
          code: 'unknow_error',
        );
}
