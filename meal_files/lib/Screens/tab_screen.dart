import 'package:flutter/material.dart';
import 'package:meal_files/Models/meal.dart';
import '../Widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal>favoriteMeals;

  const TabScreen(this.favoriteMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

   List<Map<String,Object>> _pages;

   @override
  void initState() {
     _pages= [
       {
         'page':CategoriesScreen(),
         'title':'Categories',
       },
       {
         'page':FavoritesScreen(widget.favoriteMeals),
         'title':'Your Favorites',
       },
     ];    super.initState();
  }

  int _selectedPageIndex=0;
  void _selectPage(int value) {
  setState(() {
    _selectedPageIndex=value;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex, // should tell it about current index to change state based it
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
