import 'package:dely_meals/dummy_data.dart';
import 'package:dely_meals/models/meals.dart';
import 'package:dely_meals/screens/categories_screen.dart';
import 'package:dely_meals/screens/category_meals_screen.dart';
import 'package:dely_meals/screens/filters_screen.dart';
import 'package:dely_meals/screens/meal_detail_screen.dart';
import 'package:dely_meals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];
  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) return false;
        if (_filters['lactose'] == true && !meal.isLactoseFree) return false;
        if (_filters['vegan'] == true && !meal.isVegan) return false;
        if (_filters['vegeterian'] == true && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: const Color.fromRGBO(255, 254, 229, 1),
          // colorScheme: ColorScheme.fromSwatch().copyWith(
          //   secondary: Colors.amber,
          // ),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyMedium: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: const AppBarTheme(
            color: Colors.pink,
            foregroundColor: Colors.white,
          )),
      // home: CategoriesScreen(),
      // home as defult route named '/' in routes
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}
