import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/request/request.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';

// class RepositoryImpl extends Repository
// {
//   RemoteDataSource _remoteDataSource;
//   NetworkInfo _networkInfo;
//
//   RepositoryImpl(this._remoteDataSource, this._networkInfo);
//
//   @override
//   Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
//
//     if (await _networkInfo.isConnected) {
//       try{
//         final response = await _remoteDataSource.login(loginRequest);
//
//         if (response.status == ApiInternalStatus.sucCess){
//
//           return Right(response.toDomain());
//         }else{
//           return Left(Failure(response.status ?? ApiInternalStatus.failUre,response.message?? ResponseMessage.deFault));
//
//         }
//       }catch(error){
//         return (Left(ErrorHandler.handle(error).failure));
//       }
//
//     }else{
//       return Left(DataSource.noInternetConnection.getFailure());
//
//     }
//   }
// }

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo,);

  @override
  Future<Either<Failure, Authentication>> login (LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {

      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if ( response.status == ApiInternalStatus.sucCess) // success
            {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(
              Failure(response.status ?? ApiInternalStatus.failUre,
              response.message ?? ResponseMessage.deFault),
          );
        }
      } catch (error) {
        print('Error during login: $error');
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }

  }
}