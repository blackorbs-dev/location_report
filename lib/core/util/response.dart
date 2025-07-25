import '../error/error.dart';

sealed class Response<D, E extends Error> {
  const Response();
  const factory Response.success(D data) = SuccessResponse<D, E>;
  const factory Response.error(E error) = ErrorResponse<D, E>;
}

class SuccessResponse<D, E extends Error> extends Response<D, E> {
  final D data;
  const SuccessResponse(this.data);
}
class ErrorResponse<D, E extends Error> extends Response<D, E> {
  final E error;
  const ErrorResponse(this.error);
}

extension ResponseX<T, E extends Error> on Response<T, E> {
  Response<R, E> map<R>(R Function(T data) mapper) =>
    switch(this){
      SuccessResponse(:final data) => SuccessResponse(mapper(data)),
      ErrorResponse(:final error) => ErrorResponse(error)
    };

  Response<T, E> onSuccess(void Function(T data) action) {
    if(this case SuccessResponse(:final data)){
      action(data);
    }
    return this;
  }

  Response<T, E> onError(void Function(E error) action) {
    if(this case ErrorResponse(:final error)){
      action(error);
    }
    return this;
  }
}
