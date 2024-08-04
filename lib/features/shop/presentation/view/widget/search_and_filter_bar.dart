import 'package:flutter/material.dart';

class SearchAndFilterBar extends StatelessWidget {
  final Function(String) onSearch;
  final List<String> suggestions;
  final Function(String) onSuggestionSelected;
  final Function(String) onSearchSubmitted;
  final VoidCallback onSearchFieldTap;
  final bool showSuggestions;

  const SearchAndFilterBar({
    super.key,
    required this.onSearch,
    required this.suggestions,
    required this.onSuggestionSelected,
    required this.onSearchSubmitted,
    required this.onSearchFieldTap,
    required this.showSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onTap: onSearchFieldTap,
                onChanged: onSearch,
                onSubmitted: onSearchSubmitted,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
        if (showSuggestions)
          Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () => onSuggestionSelected(suggestions[index]),
                        child: Chip(
                          label: Text(suggestions[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        const SizedBox(height: 4),
      ],
    );
  }
}
