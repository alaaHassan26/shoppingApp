import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/core/api/api_consumer.dart';
import 'package:shoping/core/api/end_ponits.dart';
import 'package:shoping/core/errors/failure.dart';
import 'package:shoping/features/home/data/models/categories_model.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/data/repos/home_repo.dart';
import "dart:convert";

class HomeRepoImpl extends HomeRepo {
  final ApiConsumer api;

  HomeRepoImpl(this.api);

  @override
  Future<Either<Failure, List<ProductModel>>> getProdctsClothes(
      {required int num}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('products_clothes');
      List<ProductModel> products = [];
      if (data != null) {
        products = (jsonDecode(data) as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
      } else {
        final response = await api.get(EndPonit.categories(num));
        for (var item in response['data']['data']) {
          products.add(ProductModel.fromJson(item));
        }
        await prefs.setString('products_clothes',
            jsonEncode(products.map((e) => e.toJson()).toList()));
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProdctsElectronicDevices(
      {required int num}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('products_electronics');
      if (data != null) {
        List<ProductModel> prodcts = (jsonDecode(data) as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(prodcts);
      } else {
        final response = await api.get(EndPonit.categories(num));
        List<ProductModel> prodcts = [];
        for (var item in response['data']['data']) {
          prodcts.add(ProductModel.fromJson(item));
        }
        await prefs.setString('products_electronics',
            jsonEncode(prodcts.map((e) => e.toJson()).toList()));
        return right(prodcts);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProdctsMedical(
      {required int num}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('products_medical');
      if (data != null) {
        List<ProductModel> prodcts = (jsonDecode(data) as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(prodcts);
      } else {
        final response = await api.get(EndPonit.categories(num));
        List<ProductModel> prodcts = [];
        for (var item in response['data']['data']) {
          prodcts.add(ProductModel.fromJson(item));
        }
        await prefs.setString('products_medical',
            jsonEncode(prodcts.map((e) => e.toJson()).toList()));
        return right(prodcts);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProdctsNew(
      {required int num}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('products_new');
      if (data != null) {
        List<ProductModel> prodcts = (jsonDecode(data) as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(prodcts);
      } else {
        final response = await api.get(EndPonit.categories(num));
        List<ProductModel> prodcts = [];
        for (var item in response['data']['data']) {
          prodcts.add(ProductModel.fromJson(item));
        }
        await prefs.setString('products_new',
            jsonEncode(prodcts.map((e) => e.toJson()).toList()));
        return right(prodcts);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProdctsSports(
      {required int num}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('products_sports');
      if (data != null) {
        List<ProductModel> prodcts = (jsonDecode(data) as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(prodcts);
      } else {
        final response = await api.get(EndPonit.categories(num));
        List<ProductModel> prodcts = [];
        for (var item in response['data']['data']) {
          prodcts.add(ProductModel.fromJson(item));
        }
        await prefs.setString('products_sports',
            jsonEncode(prodcts.map((e) => e.toJson()).toList()));
        return right(prodcts);
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> getegories() async {
    try {
      final response = await api.get(EndPonit.categoriesimage);
      List<CategoriesModel> image = [];
      for (var item in response['data']['data']) {
        image.add(CategoriesModel.fromJson(item));
      }
      return right(image);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
