import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shoping/features/home/data/models/categories_model.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;
/////////////////////////////////////////////////////////////
  Future<void> getegories() async {
    emit(GategoriesLoading());
    final response = await homeRepo.getegories();
    response.fold(
        (failure) => emit(GategoriesFaliure()),
        (categoriesModel) =>
            emit(Gategoriesuccess(getegories: categoriesModel)));
  }

/////////////////////////////////////////////////////////////////
  Future<void> getProdctsNew({required int num}) async {
    emit(GetProdctsNewLoading());
    final response = await homeRepo.getProdctsNew(num: num);
    response.fold((failure) => emit(GetProdctsNewFaliure()),
        (productModel) => emit(GetProdctsNewuccess(prodNew: productModel)));
  }

////////////////////////////////////////////////////////////////////////
  Future<void> getProdctsClothes({required int num}) async {
    emit(GetProdctsClothesLoading());
    final response = await homeRepo.getProdctsClothes(num: num);
    response.fold(
        (failure) => emit(GetProdctsClothesFaliure()),
        (productModel) =>
            emit(GetProdctsClothesSuccess(prodClothes: productModel)));
  }

////////////////////////////////////////////////////////////////////////////
  Future<void> getProdctsElectronicDevices({required int num}) async {
    emit(GetProdctsElectronicDevicesLoading());
    final response = await homeRepo.getProdctsElectronicDevices(num: num);
    response.fold(
        (failure) => emit(GetProdctsElectronicDevicesFaliure()),
        (productModel) => emit(
            GetProdctsElectronicDevicesSuccess(prodElectronic: productModel)));
  }

///////////////////////////////////////////////////////////////////////////////
  Future<void> getProdctsMedical({required int num}) async {
    emit(GetProdctsMedicalLoading());
    final response = await homeRepo.getProdctsMedical(num: num);
    response.fold(
        (failure) => emit(GetProdctsMedicalFaliure()),
        (productModel) =>
            emit(GetProdctsMedicalSuccess(prodMedical: productModel)));
  }

////////////////////////////////////////////////////////////////////////
  Future<void> getProdctsSports({required int num}) async {
    emit(GetProdctsSportsLoading());
    final response = await homeRepo.getProdctsSports(num: num);
    response.fold(
        (failure) => emit(GetProdctsSportsFaliure()),
        (productModel) =>
            emit(GetProdctsSportsSuccess(prodSports: productModel)));
  }
}
/////////////////////////////////////////////////////
//   Future<void> getProdctsNew({required int num}) async {
//     await _fetchProducts(
//       num: num,
//       key: 'products_new',
//       endpoint: EndPonit.categories(num),
//       loadingState: GetProdctsNewLoading(),
//       successState: (products) => GetProdctsNewuccess(prodNew: products),
//       failureState: GetProdctsNewFaliure(),
//     );
//   }

//   Future<void> getProdctsClothes({required int num}) async {
//     await _fetchProducts(
//       num: num,
//       key: 'products_clothes',
//       endpoint: EndPonit.categories(num),
//       loadingState: GetProdctsClothesLoading(),
//       successState: (products) =>
//           GetProdctsClothesSuccess(prodClothes: products),
//       failureState: GetProdctsClothesFaliure(),
//     );
//   }

//   Future<void> getProdctsElectronicDevices({required int num}) async {
//     await _fetchProducts(
//       num: num,
//       key: 'products_electronics',
//       endpoint: EndPonit.categories(num),
//       loadingState: GetProdctsElectronicDevicesLoading(),
//       successState: (products) =>
//           GetProdctsElectronicDevicesSuccess(prodElectronic: products),
//       failureState: GetProdctsElectronicDevicesFaliure(),
//     );
//   }

//   Future<void> getProdctsMedical({required int num}) async {
//     await _fetchProducts(
//       num: num,
//       key: 'products_medical',
//       endpoint: EndPonit.categories(num),
//       loadingState: GetProdctsMedicalLoading(),
//       successState: (products) =>
//           GetProdctsMedicalSuccess(prodMedical: products),
//       failureState: GetProdctsMedicalFaliure(),
//     );
//   }

//   Future<void> getProdctsSports({required int num}) async {
//     await _fetchProducts(
//       num: num,
//       key: 'products_sports',
//       endpoint: EndPonit.categories(num),
//       loadingState: GetProdctsSportsLoading(),
//       successState: (products) => GetProdctsSportsSuccess(prodSports: products),
//       failureState: GetProdctsSportsFaliure(),
//     );
//   }

//   Future<void> _fetchProducts({
//     required int num,
//     required String key,
//     required String endpoint,
//     required HomeState loadingState,
//     required HomeState Function(List<ProductModel>) successState,
//     required HomeState failureState,
//   }) async {
//     emit(loadingState);
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final data = prefs.getString(key);
//       if (data != null) {
//         List<ProductModel> products = (jsonDecode(data) as List)
//             .map((item) => ProductModel.fromJson(item))
//             .toList();
//         emit(successState(products));
//       } else {
//         final response = await api.get(endpoint);
//         List<ProductModel> products = [];
//         for (var item in response['data']['data']) {
//           products.add(ProductModel.fromJson(item));
//         }
//         await prefs.setString(
//             key, jsonEncode(products.map((e) => e.toJson()).toList()));
//         emit(successState(products));
//       }
//     } catch (e) {
//       emit(failureState);
//     }
//   }
// }
