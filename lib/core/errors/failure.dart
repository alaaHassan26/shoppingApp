import 'package:dio/dio.dart';
import 'package:shoping/core/api/end_ponits.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiServer');
      //
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with ApiServer');
      //
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with ApiServer');
      //
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate with ApiServer');
      //
      case DioExceptionType.badResponse:
        return ServerFailure.fromrResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      //
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was cancancel');
      //
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      //
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error , Pleass try again!');
      default:
        return ServerFailure('Opps There was an Error , Pleass try again');
    }
  }
  factory ServerFailure.fromrResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response[ApiKey.errMessage]);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Pleass try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error , Pleass try later!');
    } else {
      return ServerFailure('Opps There was an Error , Pleass try again');
    }
  }
}
