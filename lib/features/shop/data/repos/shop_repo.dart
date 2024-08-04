import 'package:dartz/dartz.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

abstract class ShooRepo {
  Future<Either<Failure, List<ProductModel>>> getProdctsNew({required int num});
  Future<Either<Failure, List<ProductModel>>> getProdctsClothes(
      {required int num});
  Future<Either<Failure, List<ProductModel>>> getProdctsElectronicDevices(
      {required int num});
  Future<Either<Failure, List<ProductModel>>> getProdctsMedical(
      {required int num});
  Future<Either<Failure, List<ProductModel>>> getProdctsSports(
      {required int num});
}
