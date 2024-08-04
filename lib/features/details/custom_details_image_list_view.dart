import 'package:flutter/material.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

class CustomDatilsImageListView extends StatefulWidget {
  const CustomDatilsImageListView({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  State<CustomDatilsImageListView> createState() =>
      _CustomDatilsImageListViewState();
}

class _CustomDatilsImageListViewState extends State<CustomDatilsImageListView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: isDarkMode ? Colors.black12 : Colors.white,
      elevation: .4,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.75,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.productModel.images?.length ?? 1,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.999,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomCategoriesImage(
                        image: widget.productModel.images?[index] ?? '',
                        width: MediaQuery.of(context).size.width * 0.999,
                        height: MediaQuery.of(context).size.width * 0.75,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _pageController,
            count: widget.productModel.images?.length ?? 1,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: colorRed,
              dotColor: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
// import 'package:shoping/features/home/presentation/views/widget/custom_categories_image.dart';

// class CustomDetailsImageListView extends StatefulWidget {
//   const CustomDetailsImageListView({
//     super.key,
//     required this.productModel,
//   });

//   final ProductModel productModel;

//   @override
//   _CustomDetailsImageListViewState createState() =>
//       _CustomDetailsImageListViewState();
// }

// class _CustomDetailsImageListViewState
//     extends State<CustomDetailsImageListView> {
//   int _currentPage = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.width * 0.75,
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: widget.productModel.images?.length ?? 1,
//               onPageChanged: (int page) {
//                 setState(() {
//                   _currentPage = page;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width * 0.999,
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: CustomCategoriesImage(
//                       image: widget.productModel.images?[index] ?? '',
//                       width: MediaQuery.of(context).size.width * 0.999,
//                       height: MediaQuery.of(context).size.width * 0.75,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 12,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List<Widget>.generate(
//             widget.productModel.images?.length ?? 1,
//             (int index) {
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                 height: 8.0,
//                 width: (index == _currentPage) ? 16.0 : 8.0,
//                 decoration: BoxDecoration(
//                   color: (index == _currentPage) ? Colors.blue : Colors.grey,
//                   borderRadius: BorderRadius.circular(4.0),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
