import 'package:flutter/material.dart';
import 'package:meals_application/data/dummy_data.dart';
import 'package:meals_application/screens/catescreen.dart';
import 'package:meals_application/screens/filterscreen.dart';
import 'package:meals_application/screens/meals.dart';

import '../model/mealsmodel.dart';
import '../widgets/customDrawer.dart';

const kIntialfilters = {
  Filter.glutenfree: false,
  Filter.lactosefree: false,
  Filter.vegetarain: false,
  Filter.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Meal> selfav = [];
  Map<Filter, bool> map = kIntialfilters;
  int _index = 0;
  void showmessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void toogleselfav(Meal meal) {
    bool isexist = selfav.contains(meal);
    if (isexist) {
      setState(() {
        selfav.remove(meal);
        showmessage("Item is removed from Favourite");
      });
    } else {
      setState(() {
        selfav.add(meal);
        showmessage("Item is added from Favourite");
      });
    }
  }

  void _selectedpage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final avlmeals = dummyMeals.where((meal) {
      if (map[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (map[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (map[Filter.vegetarain]! && !meal.isVegetarian) {
        return false;
      }
      if (map[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget curscreen = CategoriesScreen(
      avlmeals: avlmeals,
      ontoogle: toogleselfav,
    );
    var activepagetitle = 'Categories';
    if (_index == 1) {
      curscreen = MealsScreen(
        meals: selfav,
        ontoogle: toogleselfav,
      );
      activepagetitle = 'Your Favourites';
    }
    void showscreen(String str) async {
      Navigator.of(context).pop();
      if (str == "filter") {
        final result = await Navigator.of(context)
            .push<Map<Filter, bool>>(MaterialPageRoute(
                builder: (ctx) => FilterScreen(
                      curfilters: map,
                    )));
        setState(() {
          map = result ?? kIntialfilters;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: CustomDrawer(
        showScreen: showscreen,
      ),
      body: curscreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: _selectedpage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.set_meal,
                ),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites'),
          ]),
    );
  }
}
