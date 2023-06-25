import 'package:flutter/material.dart';
import 'package:meal_files/Models/meal.dart';
import 'package:meal_files/Screens/category_meals_screen.dart';
import 'package:meal_files/Screens/filters_screens.dart';
import '../dummy_data.dart';
import './Screens/tab_screen.dart';
import './Screens/meal_detail_screen.dart';
//import './Screens/categories_screen.dart';

/*
 ------------- The difference between './' and '../' -------------

  './' ==> to go back one step ,si i exist in tap main so i need one step to go back to lib


 '../' ==> to go back two steps ,si if i exist in tap _CategoryItem so i need two steps to go back to lib
(Going back will be from _CategoryItem to screens then to lib

 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List <Meal> _availableMeals = DUMMY_MEALS ;
  List <Meal> _favoriteMeals = [] ;

  void _setfilters(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false; // it means doesn't return this type
        }
      return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id==mealId); // func indexWhere ==> if condition didn't verify ,it will return me -1
if(existingIndex==-1){
  setState(() {
    _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
  });
}
else{
  setState(() {
     _favoriteMeals.removeAt(existingIndex);
  });
}
  }

  bool _isMealFavorites(String id){
    return _favoriteMeals.any((meal) => meal.id==id); // it will return true or false
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        // secondary represents accentColor before update
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // background of body takes the color from canvasColor
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            bodyMedium: TextStyle(
              color: Color.fromRGBO(20, 50, 50, 1),
            ),
            titleMedium: TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      // home: MyHomePage(),
      //  home: CategoriesScreen(), // routes is equal to this line
      routes: {
        '/': (context) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routeNamed: (context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routNamed: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorites),
        FiltersScreen.routNamed: (context) => FiltersScreen(_filters,_setfilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: null,
    );
  }
}
