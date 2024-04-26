import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  const FavouriteScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Center(
          child: Text("You have no favourite yet - start adding some!"));
    } else {
      return ListView.builder(
        itemCount: favouriteMeals.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
            imageUrl: favouriteMeals[index].imageUrl,
            title: favouriteMeals[index].title,
          );
        },
      );
    }
  }
}
