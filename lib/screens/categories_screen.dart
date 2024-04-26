import 'package:dely_meals/widgets/category_item.dart';
import 'package:dely_meals/dummy_data.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: DUMMY_CATEGORIES
          .map((e) => CategoryItem(id: e.id, color: e.color, title: e.title))
          .toList(),
    );
  }
}
