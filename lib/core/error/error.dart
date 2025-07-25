abstract class Error{}

sealed class DataError implements Error {
  const DataError();

  const factory DataError.unknown() = UnknownError;
  const factory DataError.platform({required String? message}) = PlatformError;
  const factory DataError.serialization() = SerializationError;
  const factory DataError.timeout() = TimeoutError;
  const factory DataError.message(String message) = ErrorMessage;
}

class UnknownError extends DataError {
  const UnknownError();
}

class PlatformError extends DataError {
  final String? message;
  const PlatformError({required this.message});
}

class SerializationError extends DataError {
  const SerializationError();
}

class TimeoutError extends DataError {
  const TimeoutError();
}

class ErrorMessage extends DataError {
  final String message;
  const ErrorMessage(this.message);
}
