import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

@module
abstract class RegisterModule {
  @singleton
  http.Client get httpClient => http.Client();

  @singleton
  Logger get logger => Logger();
}
