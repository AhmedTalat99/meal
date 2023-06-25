import 'package:flutter/material.dart';
import 'package:meal_files/Screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    this.id,
    this.title,
    this.color,
  });

  void SelectedCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeNamed,
        arguments: {
        'id':id,
          'title':title,
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        return SelectedCategory(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title),
      ),
    );
  }
}
