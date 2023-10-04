import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meals_application/data/dummy_data.dart';
import 'package:meals_application/model/categories_model.dart';
import 'package:meals_application/screens/meals.dart';
import 'package:meals_application/widgets/categorygriditem.dart';

import '../model/mealsmodel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key, required this.ontoogle, required this.avlmeals});

  final void Function(Meal meal) ontoogle;
  final List<Meal> avlmeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(microseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectedCategory(BuildContext context, Categories categories) {
    final slectedlist = widget.avlmeals
        .where((meal) => meal.categories.contains(categories.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => MealsScreen(
              title: categories.title,
              meals: slectedlist,
              ontoogle: widget.ontoogle,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
      child: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 3 / 2),
        children: [
          for (final categories in availableCategories)
            CategoryGridItem(
              categories: categories,
              onSelectedCategory: () {
                _selectedCategory(context, categories);
              },
            )
        ],
      ),
    );
  }
}
