import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/data/repos/shop_repo.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(this.shooRepo) : super(ShopInitial());
  final ShooRepo shooRepo;
  List<ProductModel> allProducts = [];

  Future<void> getProdctsNew({required int num}) async {
    emit(GetProdctsNewLoading());
    final response = await shooRepo.getProdctsNew(num: num);
    response.fold(
      (failure) => emit(GetProdctsNewFaliure()),
      (productModel) {
        addProducts(productModel);
        emit(GetProdctsNewuccess(prodNew: productModel));
      },
    );
  }

  Future<void> getProdctsClothes({required int num}) async {
    emit(GetProdctsClothesLoading());
    final response = await shooRepo.getProdctsClothes(num: num);
    response.fold(
      (failure) => emit(GetProdctsClothesFaliure()),
      (productModel) {
        addProducts(productModel);
        emit(GetProdctsClothesSuccess(prodClothes: productModel));
      },
    );
  }

  Future<void> getProdctsElectronicDevices({required int num}) async {
    emit(GetProdctsElectronicDevicesLoading());
    final response = await shooRepo.getProdctsElectronicDevices(num: num);
    response.fold(
      (failure) => emit(GetProdctsElectronicDevicesFaliure()),
      (productModel) {
        addProducts(productModel);
        emit(GetProdctsElectronicDevicesSuccess(prodElectronic: productModel));
      },
    );
  }

  Future<void> getProdctsMedical({required int num}) async {
    emit(GetProdctsMedicalLoading());
    final response = await shooRepo.getProdctsMedical(num: num);
    response.fold(
      (failure) => emit(GetProdctsMedicalFaliure()),
      (productModel) {
        addProducts(productModel);
        emit(GetProdctsMedicalSuccess(prodMedical: productModel));
      },
    );
  }

  Future<void> getProdctsSports({required int num}) async {
    emit(GetProdctsSportsLoading());
    final response = await shooRepo.getProdctsSports(num: num);
    response.fold(
      (failure) => emit(GetProdctsSportsFaliure()),
      (productModel) {
        addProducts(productModel);
        emit(GetProdctsSportsSuccess(prodSports: productModel));
      },
    );
  }

///////////////البحث//////////////////////////

  void addProducts(List<ProductModel> newProducts) {
    final productIds = allProducts.map((product) => product.id).toSet();
    for (var product in newProducts) {
      if (!productIds.contains(product.id)) {
        allProducts.add(product);
      }
    }
  }
}
