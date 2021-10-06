import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters-screen";
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.saveFilters, this.currentFilters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarion = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"];
    _vegan = widget.currentFilters["vegan"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegetarion = widget.currentFilters["vegetarion"];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      activeColor: Colors.indigo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filters"),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    "gluten": _glutenFree,
                    "lactose": _lactoseFree,
                    "vegan": _vegan,
                    "vegetarion": _vegetarion
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Adjust your Meal selection",
                  style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile("Gluten-free",
                    "Only includes gluten-free meals", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Lactose-free",
                    "Only includes lactose-free meals",
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegetarian", "Only includes vegetarian meals", _vegetarion,
                    (newValue) {
                  setState(() {
                    _vegetarion = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegan", "Only includes vegen meals", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
