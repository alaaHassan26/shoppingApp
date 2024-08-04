part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GategoriesLoading extends HomeState {}

final class Gategoriesuccess extends HomeState {
  final List<CategoriesModel> getegories;

  Gategoriesuccess({required this.getegories});
}

final class GategoriesFaliure extends HomeState {}

///////////////////////////////////////////////////

final class GetProdctsNewLoading extends HomeState {}

final class GetProdctsNewuccess extends HomeState {
  final List<ProductModel> prodNew;

  GetProdctsNewuccess({required this.prodNew});
}

final class GetProdctsNewFaliure extends HomeState {}

//////////////////////////////////////////////////////////

final class GetProdctsElectronicDevicesLoading extends HomeState {}

final class GetProdctsElectronicDevicesSuccess extends HomeState {
  final List<ProductModel> prodElectronic;

  GetProdctsElectronicDevicesSuccess({required this.prodElectronic});
}

final class GetProdctsElectronicDevicesFaliure extends HomeState {}

///////////////////////////////////////////////////////////////

final class GetProdctsClothesLoading extends HomeState {}

final class GetProdctsClothesSuccess extends HomeState {
  final List<ProductModel> prodClothes;

  GetProdctsClothesSuccess({required this.prodClothes});
}

final class GetProdctsClothesFaliure extends HomeState {}

////////////////////////////////////////////////

final class GetProdctsMedicalLoading extends HomeState {}

final class GetProdctsMedicalSuccess extends HomeState {
  final List<ProductModel> prodMedical;

  GetProdctsMedicalSuccess({required this.prodMedical});
}

final class GetProdctsMedicalFaliure extends HomeState {}

/////////////////////////////////////////////////////////////

final class GetProdctsSportsLoading extends HomeState {}

final class GetProdctsSportsSuccess extends HomeState {
  final List<ProductModel> prodSports;

  GetProdctsSportsSuccess({required this.prodSports});
}

final class GetProdctsSportsFaliure extends HomeState {}
