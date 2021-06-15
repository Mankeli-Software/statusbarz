class StatusbarzException implements Exception {
  final dynamic message;

  StatusbarzException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
