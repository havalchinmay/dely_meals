import 'package:flutter/material.dart';

import 'package:dely_meals/screens/categories_screen.dart';
import 'package:dely_meals/screens/favourites_screen.dart';
import 'package:dely_meals/widgets/main_drawer.dart';
import '../models/meals.dart';

// For creating tabs in your app at the top below appbar
// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key});

//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Meals'),
//             bottom: const TabBar(tabs: [
//               Tab(
//                 icon: Icon(
//                   Icons.category,
//                   color: Colors.white,
//                 ),
//                 child: Text('Categories'),
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.star,
//                   color: Colors.white,
//                 ),
//                 child: Text('Favorites'),
//               )
//             ]),
//           ),
//           body: const TabBarView(children: [
//             CategoriesScreen(),
//             FavouriteScreen(),
//           ]),
//         ));
//   }
// }

// to create bottomBar
class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  const TabsScreen(this.favouriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>>? _pages;

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavouriteScreen(widget.favouriteMeals),
        'title': 'Your Favourite'
      }
    ];
    super.initState();
  }

  int selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_pages![selectedIndex]['title'] as String)),
      ),
      drawer: MainDrawer(),
      body: (_pages![selectedIndex]['page']) as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.pink,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: selectedIndex,
        //type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
