import 'package:flutter/material.dart';

import 'package:dely_meals/models/meals.dart';
import 'package:dely_meals/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-Meals';
  final List<Meal> availbaleMeals;
  const CategoryMealsScreen(this.availbaleMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id']!;
      displayedMeals = widget.availbaleMeals.where(
        (element) {
          return element.categories.contains(categoryId);
        },
      ).toList();
      loadedInitData = true;
      super.didChangeDependencies();
    }
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemCount: displayedMeals!.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals![index].id,
            affordability: displayedMeals![index].affordability,
            complexity: displayedMeals![index].complexity,
            duration: displayedMeals![index].duration,
            imageUrl: displayedMeals![index].imageUrl,
            title: displayedMeals![index].title,
            // removeItem: _removeMeal,
          );
        },
      ),
    );
  }
}
