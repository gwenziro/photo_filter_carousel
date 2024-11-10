import 'package:flutter/material.dart';
import 'filter_item.dart';

@immutable
class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  });

  final List<Color> filters;
  final void Function(Color selectedColor) onFilterChanged;
  final EdgeInsets padding;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;

  int get filterCount => widget.filters.length;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: _viewportFractionPerItem);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: PageView.builder(
        controller: _controller,
        itemCount: filterCount,
        onPageChanged: (page) {
          setState(() {});
          widget.onFilterChanged(widget.filters[page]);
        },
        itemBuilder: (context, index) {
          return FilterItem(
            color: widget.filters[index],
            onFilterSelected: () {
              _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      ),
    );
  }
}
