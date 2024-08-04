part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

final class GetProdctsNewLoading extends ShopState {}

final class GetProdctsNewuccess extends ShopState {
  final List<ProductModel> prodNew;

  GetProdctsNewuccess({required this.prodNew});
}

final class GetProdctsNewFaliure extends ShopState {}

//////////////////////////////////////////////////////////

final class GetProdctsElectronicDevicesLoading extends ShopState {}

final class GetProdctsElectronicDevicesSuccess extends ShopState {
  final List<ProductModel> prodElectronic;

  GetProdctsElectronicDevicesSuccess({required this.prodElectronic});
}

final class GetProdctsElectronicDevicesFaliure extends ShopState {}

///////////////////////////////////////////////////////////////

final class GetProdctsClothesLoading extends ShopState {}

final class GetProdctsClothesSuccess extends ShopState {
  final List<ProductModel> prodClothes;

  GetProdctsClothesSuccess({required this.prodClothes});
}

final class GetProdctsClothesFaliure extends ShopState {}

////////////////////////////////////////////////

final class GetProdctsMedicalLoading extends ShopState {}

final class GetProdctsMedicalSuccess extends ShopState {
  final List<ProductModel> prodMedical;

  GetProdctsMedicalSuccess({required this.prodMedical});
}

final class GetProdctsMedicalFaliure extends ShopState {}

/////////////////////////////////////////////////////////////

final class GetProdctsSportsLoading extends ShopState {}

final class GetProdctsSportsSuccess extends ShopState {
  final List<ProductModel> prodSports;

  GetProdctsSportsSuccess({required this.prodSports});
}

final class GetProdctsSportsFaliure extends ShopState {}
