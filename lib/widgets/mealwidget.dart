import 'package:flutter/material.dart';
import 'package:meals_application/widgets/mealitemtrait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/mealsmodel.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({super.key, required this.meal, required this.onselectmeal});
  final Meal meal;
  final void Function(BuildContext context, Meal meal) onselectmeal;
  String get Complexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get Affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onselectmeal(context, meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 250,
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: '${meal.duration} min'),
                          const SizedBox(
                            width: 9,
                          ),
                          MealItemTrait(icon: Icons.work, label: Complexity),
                          const SizedBox(
                            width: 9,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money, label: Affordability),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}