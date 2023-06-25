import 'package:flutter/material.dart';
import 'package:meal_files/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routNamed = 'meal_detail';
  final Function toggleFavorites;
  final Function isFavorties;

   MealDetailScreen( this.toggleFavorites,this.isFavorties);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
// we will do filtering

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) =>
        meal.id == mealId); // يعني أول عنصر يحقق الشرط يتم إضافته وينتهي

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => ListTile(
                  // Note: color here is taken from primary color
                  leading: CircleAvatar(
                    child: Text('# ${index+1}'),
                  ),
                  title: Text(selectedMeal.steps[index],style: TextStyle(fontSize: 15),),
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
floatingActionButton: FloatingActionButton(
  onPressed:()=> toggleFavorites(mealId),
  child: Icon(
    // isFavorties will take turn between add and remove
      isFavorties(mealId)?Icons.star:Icons.star_border,
  ),
),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      width: 300,
      height: 150,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
