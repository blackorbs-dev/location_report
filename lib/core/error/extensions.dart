import 'package:flutter/foundation.dart';

import 'error.dart';

extension ExceptionLogger on Object {
  void printDebug({String tag = ''}) {
    if(kDebugMode) {
      debugPrint('$tag: $this');
    }
  }
}

extension Message on DataError{
  String message() => switch(this){
    ErrorMessage(:final message) => message,
    PlatformError(:final message) => message ??
        'Oops, something went wrong, please try again.',
    _ => 'Oops, something went wrong, please try again.'
  };
}