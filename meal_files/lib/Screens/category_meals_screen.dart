import 'package:flutter/material.dart';
import '../Models/meal.dart';
import '../Widgets/meal_item.dart';
//import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeNamed = 'Category_meals';

final List<Meal> availableMeals;

   CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal>displayedMeals;

  @override
  void didChangeDependencies() {
    /* This func is useful when changing state ,also it implements fast as like initState*/
    // to reach to arguments i will do the following :
    final routeArg =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    // now i will extract each element
    final CategoryId = routeArg['id'];
     categoryTitle = routeArg['title'];
    // For categoryMeals i did filtering for list to show each description inside type of meal itself
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(CategoryId);
    }).toList() as dynamic;
    super.didChangeDependencies();
  }

 void _removeMeal(String mealId) {
      setState(() {
        displayedMeals.removeWhere((meal) => meal.id==mealId);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }


}
