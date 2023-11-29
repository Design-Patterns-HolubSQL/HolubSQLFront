import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class SearchSelect extends StatefulWidget {
  const SearchSelect({super.key});

  @override
  State<SearchSelect> createState() => _SearchSelectState();
}

class _SearchSelectState extends State<SearchSelect> {
  List<String> ingredient = [
    'Tomato',
    'Beef',
    'Chicken',
    'Shrimp',
    'Broccoli',
    'Mushroom',
    'Onion',
    'Garlic',
    'Cheese',
    'Spinach',
    'Lettuce',
    'Egg',
    'Soy Sauce',
    'Rice',
    'Pasta',
    'Bell Pepper',
    'Olive Oil',
    'Flour',
    'Milk',
    'Sugar',
    'Salt',
    'Pepper',
    'Cilantro',
    'Lemon',
    'Ginger',
    'Basil',
    'Oregano',
    'Paprika',
    'Cumin',
    'Honey'
  ];
  List<String> type = ['korean', 'japanese', 'chinese', 'western'];
  List<String> distance = ['5', '10', '15', '20', '25', '30'];

  List<String> selectedIngredient = [];
  List<String> selectedDistance = [];
  List<String> selectedType = [];
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter text',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    //multiple: true,
                    clearable: true,
                    value: selectedIngredient,
                    onChanged: (value) {
                      setState(() => selectedIngredient = value);
                    },
                    itemCount: ingredient.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(ingredient[i]),
                        onSelected: state.onSelected(ingredient[i]),
                        label: Text(ingredient[i]),
                      );
                    },
                    listBuilder: ChoiceList.createScrollable(
                      spacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 100,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Ingredient',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    //multiple: true,
                    clearable: true,
                    value: selectedDistance,
                    onChanged: (value) {
                      setState(() => selectedDistance = value);
                    },
                    itemCount: distance.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(distance[i]),
                        onSelected: state.onSelected(distance[i]),
                        label: Text(distance[i]),
                      );
                    },
                    listBuilder: ChoiceList.createScrollable(
                      spacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 100,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Distance',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    //multiple: true,
                    clearable: true,
                    value: selectedType,
                    onChanged: (value) {
                      setState(() => selectedType = value);
                    },
                    itemCount: type.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(type[i]),
                        onSelected: state.onSelected(type[i]),
                        label: Text(type[i]),
                      );
                    },
                    listBuilder: ChoiceList.createScrollable(
                      spacing: 10,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: 100,
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Type',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              List<String> selectedValues = [];
              List<String> coor = ["126.808343", "37.675393"];
              selectedValues.add(_searchController.text);
              selectedValues.addAll(selectedIngredient);
              selectedValues.addAll(selectedDistance);
              selectedValues.addAll(coor);
              selectedValues.addAll(selectedType);
              Navigator.pop(context, selectedValues);
            },
            icon: Icon(Icons.search)),
      ],
    );
  }
}
