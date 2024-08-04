import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/core/utils/app_localiizations.dart';
import 'package:shoping/core/utils/appstyles.dart';
import 'package:shoping/core/utils/colors.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';
import 'package:shoping/features/shop/presentation/manger/shop_cubit/shop_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/features/shop/presentation/view/widget/tab_bar_view_page.dart';

class ShopViewNew extends StatefulWidget {
  const ShopViewNew({super.key});

  @override
  State<StatefulWidget> createState() => _ShopViewNewState();
}

class _ShopViewNewState extends State<ShopViewNew>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchText = '';
  List<ProductModel> filteredProducts = [];
  List<String> previousSearches = [];
  bool showSuggestions = false;
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    loadPreviousSearches();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      previousSearches = prefs.getStringList('previousSearches') ?? [];
    });
  }

  Future<void> saveSearch(String search) async {
    final prefs = await SharedPreferences.getInstance();
    if (search.isNotEmpty && !previousSearches.contains(search)) {
      previousSearches.add(search);
      await prefs.setStringList('previousSearches', previousSearches);
    }
  }

  void onSearch(String text) {
    setState(() {
      searchText = text;
      showSuggestions = text.isNotEmpty;
      isSearching = text.isNotEmpty;
      filteredProducts = context.read<ShopCubit>().allProducts.where((product) {
        final nameLower = product.name?.toLowerCase() ?? '';
        final searchLower = searchText.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    });
  }

  void onSuggestionSelected(String suggestion) {
    setState(() {
      searchText = suggestion;
      showSuggestions = false;
      isSearching = true;
      _searchController.text = suggestion;
      filteredProducts = context.read<ShopCubit>().allProducts.where((product) {
        final nameLower = product.name?.toLowerCase() ?? '';
        final searchLower = searchText.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    });
  }

  void onSearchSubmitted(String text) {
    saveSearch(text);
    setState(() {
      searchText = text;
      showSuggestions = false;
      isSearching = text.isNotEmpty;
      filteredProducts = context.read<ShopCubit>().allProducts.where((product) {
        final nameLower = product.name?.toLowerCase() ?? '';
        final searchLower = searchText.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    });
  }

  void onSearchFieldTap() {
    setState(() {
      showSuggestions = true;
    });
  }

  void onCancelSearch() {
    setState(() {
      searchText = '';
      isSearching = false;
      showSuggestions = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black12 : const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0, // Flat design
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.translate('shopping'),
          style: AppStyles.styleSemiBold24(context),
        ),
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onCancelSearch,
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: AppStyles.styleMedium16(context),
              onChanged: onSearch,
              onSubmitted: onSearchSubmitted,
              onTap: onSearchFieldTap,
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText:
                    AppLocalizations.of(context)!.translate('searchproducts'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: isDarkMode
                    ? Colors.black
                    : Colors.white, // White background for search
              ),
            ),
          ),
          if (showSuggestions)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButton<String>(
                style: AppStyles.styleMedium16(context),
                value: null,
                hint: Text(
                  AppLocalizations.of(context)!
                      .translate('clickforsuggestions'),
                  style: AppStyles.styleMedium16(context),
                ),
                isExpanded: true,
                items: previousSearches
                    .where((search) =>
                        search.toLowerCase().contains(searchText.toLowerCase()))
                    .map<DropdownMenuItem<String>>((String suggestion) {
                  return DropdownMenuItem<String>(
                    value: suggestion,
                    child: Text(
                      suggestion,
                      style: AppStyles.styleMedium16(context),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onSuggestionSelected(newValue);
                  }
                },
              ),
            ),
          TabBar(
            labelPadding: const EdgeInsets.symmetric(horizontal: 0),
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: colorRed,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                  text: AppLocalizations.of(context)!
                      .translate('electrionicdevices1')),
              Tab(text: AppLocalizations.of(context)!.translate('sports')),
              Tab(text: AppLocalizations.of(context)!.translate('clothes')),
              Tab(text: AppLocalizations.of(context)!.translate('medical')),
            ],
            labelStyle: AppStyles.styleSemiBold20(context),
          ),
          TabBarViewPage(
              isSearching: isSearching,
              filteredProducts: filteredProducts,
              tabController: _tabController),
        ],
      ),
    );
  }
}
