import 'package:flutter/material.dart';
import 'package:meals_application/screens/mealsdetail.dart';
import 'package:meals_application/widgets/mealwidget.dart';

import '../model/mealsmodel.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {Key? key, this.title, required this.meals, required this.ontoogle});
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) ontoogle;
  void selectmeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => MealDetailScreen(
              meal: meal,
              ontoogle: ontoogle,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealWidget(
                meal: meals[index],
                onselectmeal: ((context, meal) {
                  selectmeal(context, meal);
                }),
              ));
    }
    if (title == null) return content;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
