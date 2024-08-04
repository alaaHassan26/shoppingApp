// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoping/cache/cache_helper.dart';
// import 'package:shoping/core/utils/app_localiizations.dart';
// import 'package:shoping/core/utils/appstyles.dart';
// import 'package:shoping/features/favorites/data/models/favorite_model.dart';
// import 'package:shoping/features/favorites/presentation/manger/cubit/favorite_cubit.dart';
// import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
// import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({Key? key}) : super(key: key);

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   @override
//   void initState() {
//     context.read<FavoriteCubit>().fetchFavoriteProducts();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('المفضلة'),
//       ),
//       body: BlocBuilder<FavoriteCubit, FavoriteState>(
//         builder: (context, state) {
//           if (state is FavoriteLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is FavoriteLoaded) {
//             if (state.favoriteProducts.isEmpty) {
//               return const Center(child: Text('لا توجد منتجات مفضلة'));
//             }

//             return ListView.builder(
//               itemCount: state.favoriteProducts.length,
//               itemBuilder: (context, index) {
//                 final favoriteProduct = state.favoriteProducts[index];
//                 return FavoriteProductItem(favoriteProduct: favoriteProduct);
//               },
//             );
//           } else if (state is FavoriteError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text('لا توجد منتجات مفضلة'));
//           }
//         },
//       ),
//     );
//   }
// }

// class FavoriteProductItem extends StatelessWidget {
//   const FavoriteProductItem({
//     Key? key,
//     required this.favoriteProduct,
//   }) : super(key: key);

//   final FavoriteProduct favoriteProduct;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // GoRouter.of(context)
//         //     .push(AppRouter.kCustomDetailsViewItem, extra: favoriteProduct);
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
//         child: Container(
//           height: MediaQuery.of(context).size.height * .26,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   bottomLeft: Radius.circular(8),
//                 ),
//                 child: CustomCategoriesImage(
//                   image: favoriteProduct.product.image ??
//                       '', // استبدل برابط الصورة الفعلي
//                   width: MediaQuery.of(context).size.width * 0.4,
//                   height: MediaQuery.of(context).size.height * 0.25,
//                 ),
//               ),
//               Flexible(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         child: Text(favoriteProduct.product.name ?? "",
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: AppStyles.styleSemiBold18(context)),
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                       Row(
//                         children: [
//                           const FittedBox(
//                             alignment: AlignmentDirectional.centerStart,
//                             fit: BoxFit.scaleDown,
//                             child: Text('Discount'),
//                           ),
//                           const SizedBox(
//                             width: 8,
//                           ),
//                           FittedBox(
//                             alignment: AlignmentDirectional.centerStart,
//                             fit: BoxFit.scaleDown,
//                             child: Text(
//                               favoriteProduct.product.discount.toString(),
//                               style: const TextStyle(
//                                   color: Colors.grey, fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           FittedBox(
//                             alignment: AlignmentDirectional.centerStart,
//                             fit: BoxFit.scaleDown,
//                             child: Text(
//                                 AppLocalizations.of(context)!
//                                     .translate('pirce'),
//                                 style: AppStyles.styleSemiBold18(context)
//                                     .copyWith(color: colorRed)),
//                           ),
//                           const SizedBox(width: 8),
//                           FittedBox(
//                             alignment: AlignmentDirectional.centerStart,
//                             fit: BoxFit.scaleDown,
//                             child: Text(
//                               favoriteProduct.product.price.toString(),
//                               style: AppStyles.styleRegular16(context),
//                             ),
//                           ),
//                           FavoriteIconButtonFavo(
//                             productModel: favoriteProduct.product,
//                           ) // استخدام FavoriteIconButton مع Product
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FavoriteIconButtonFavo extends StatefulWidget {
//   final ProductModel productModel;

//   const FavoriteIconButtonFavo({Key? key, required this.productModel})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _FavoriteIconButtonFavoState();
// }

// class _FavoriteIconButtonFavoState extends State<FavoriteIconButtonFavo> {
//   final CacheHelper _cacheHelper = CacheHelper();

//   @override
//   void initState() {
//     super.initState();
//     _loadFavoriteState();
//   }

//   Future<void> _loadFavoriteState() async {
//     await _cacheHelper.init(); // Initialize CacheHelper
//     setState(() {
//       widget.productModel.inFavorites = _cacheHelper.getDataString(
//               key: 'isFavorite_${widget.productModel.id}') ==
//           'true'; // Check if the value is 'true'
//     });
//   }

//   void _toggleFavorite() async {
//     setState(() {
//       widget.productModel.inFavorites = !widget.productModel.inFavorites;
//     });

//     await _cacheHelper.saveData(
//         key: 'isFavorite_${widget.productModel.id}',
//         value: widget.productModel.inFavorites.toString());

//     if (widget.productModel.inFavorites) {
//       BlocProvider.of<FavoriteCubit>(context)
//           .removeProductFromFavorites(widget.productModel.id!);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('تمت إزالة المنتج من المفضلة'),
//         ),
//       );
//     } else {
//       BlocProvider.of<FavoriteCubit>(context)
//           .addProductToFavorites(widget.productModel.id!);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('تمت إزالة المنتج من المفضلة'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleFavorite,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Icon(
//           widget.productModel.inFavorites
//               ? Icons.favorite
//               : Icons.favorite_border,
//           color: widget.productModel.inFavorites ? colorRed : Colors.grey,
//         ),
//       ),
//     );
//   }
// }
