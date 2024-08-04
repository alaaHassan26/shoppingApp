import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoping/core/utils/app_router.dart';
import 'package:shoping/features/home/data/models/image_model.dart';
import 'package:shoping/features/home/presentation/views/widget/image_apsectration.dart';

class MyCardPageViwe extends StatelessWidget {
  const MyCardPageViwe({super.key, required this.pageController});
  final PageController pageController;

  static const List<ImageModel> images = [
    ImageModel('assets/images/elediev.jpg'),
    ImageModel('assets/images/kor2.jpg'),
    ImageModel('assets/images/med.jpg'),
    ImageModel('assets/images/liht5.jpg'),
    ImageModel('assets/images/clos4.png'),
  ];
  void navigateToScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).push(AppRouter.kEletroinDeviecsViewAll);
        break;
      case 1:
        GoRouter.of(context).push(AppRouter.kMedicalViewAll);
        break;
      case 2:
        GoRouter.of(context).push(AppRouter.kSportsViewAll);
        break;
      case 3:
        GoRouter.of(context).push(AppRouter.kNewViewAll);
        break;
      case 4:
        GoRouter.of(context).push(AppRouter.kClothesViewAll);
        break;
      // أضف المزيد من الحالات إذا كان لديك المزيد من الصفحات
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: List.generate(images.length, (index) {
        return ImageApsectratio(
          imageModel: images[index],
          onTap: () => navigateToScreen(context, index),
        );
      }),
    );
  }
}































// import 'package:expandable_page_view/expandable_page_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoping/features/home/presentation/manger/cubit/home_cubit.dart';
// import 'package:shoping/features/home/presentation/views/widget/image_apsectration.dart';

// class MyCardPageViwe extends StatefulWidget {
//   const MyCardPageViwe({super.key, required this.pageController});
//   final PageController pageController;

//   @override
//   State<MyCardPageViwe> createState() => _MyCardPageViweState();
// }

// class _MyCardPageViweState extends State<MyCardPageViwe> {
//   @override
//   void initState() {
//     context.read<HomeCubit>().getegories();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state is GategoriesFaliure) {
//           return const Text('Error');
//         } else if (state is Gategoriesuccess) {
//           return ExpandablePageView(
//             controller: widget.pageController,
//             scrollDirection: Axis.horizontal,
//             children: List.generate(
//               state.getegories.length,
//               (index) => ImageApsectratio(gategoriees: state.getegories[index]),
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
