abstract class BaseException implements Exception {
  final String message;
  BaseException(this.message);
}

class ServerException extends BaseException {
  ServerException([super.message = "Server Error"]);
}

class CacheException extends BaseException {
  CacheException([super.message = "Cache Error"]);
}

class ParseException extends BaseException {
  ParseException([super.message = "Parse Error"]);
}
