import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  deFault
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handlerError(error);
    } else {
      failure = DataSource.deFault.getFailure();
    }
  }

  Failure _handlerError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeOut.getFailure();

      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeOut.getFailure();

      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeOut.getFailure();

      case DioExceptionType.badCertificate:
        return DataSource.badRequest.getFailure();

      case DioExceptionType.badResponse:
        switch (error.response?.statusCode){
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unAuthorised:
            return DataSource.unAuthorised.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.success.getFailure();
        }

      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();

      case DioExceptionType.connectionError:
        return DataSource.internalServerError.getFailure();

      case DioExceptionType.unknown:
        return DataSource.deFault.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);

      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);

      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);

      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);

      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);

      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);

      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);

      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);

      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);

      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.deFault:
        return Failure(ResponseCode.deFault, ResponseMessage.deFault);

      default:
        return Failure(ResponseCode.deFault, ResponseMessage.deFault);
    }
  }
}

class ResponseCode {
  // API status code
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unAuthorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  //local status code
  static const int deFault = -1;
  static const int connectTimeOut = -2;
  static const int cancel = -3;
  static const int receiveTimeOut = -4;
  static const int sendTimeOut = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status message
  static const String success = "Success";
  static const String noContent = "Success with no content";
  static const String badRequest = "Bad request try again later";
  static const String forbidden = "Forbidden request try again later";
  static const String unAuthorised = "User is un authorised try again";
  static const String notFound = "Url is not found try again";
  static const String internalServerError = 'Something went wrong,try again';

  //local status message
  static const String deFault = "Something went wrong,try againnnnnn";
  static const String connectTimeOut = "Time out error,try again";
  static const String cancel = "Request is canceled,try again";
  static const String receiveTimeOut = "Time out error,try again";
  static const String sendTimeOut = "Time out error,try again";
  static const String cacheError = "Cache error, try again";
  static const String noInternetConnection =
      "Please check your internet connection";
}
class ApiInternalStatus{
  static const int sucCess = 0;
  static const int failUre = 1;
}

