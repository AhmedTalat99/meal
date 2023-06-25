import 'package:flutter/material.dart';
import 'package:meal_files/Screens/filters_screens.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Meal',Icons.restaurant,(){Navigator.of(context).pushReplacementNamed('/');}),
          buildListTile('Filters',Icons.settings,(){Navigator.of(context).pushReplacementNamed(FiltersScreen.routNamed);}),

        ],
      ),
    );
  }

  Widget buildListTile(String title,IconData icon,Function tapHandler) {
    return ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            fontFamily: 'RobotoCondensed',
            ),
          ),
        onTap: tapHandler,
        );
  }
}
