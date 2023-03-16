/// {@template statusbarz_exception}
/// An exception thrown by the `Statusbarz` library
/// {@endtemplate}
class StatusbarzException implements Exception {
  /// {@macro statusbarz_exception}
  StatusbarzException([this.message]);

  /// The message to be delivered
  final dynamic message;

  @override
  String toString() {
    final message = this.message;
    if (message == null) return 'Exception';

    return 'Exception: $message';
  }
}
