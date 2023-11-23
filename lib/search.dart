import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

class SearchSelect extends StatefulWidget {
  const SearchSelect({super.key});

  @override
  State<SearchSelect> createState() => _SearchSelectState();
}

class _SearchSelectState extends State<SearchSelect> {
  List<String> group1 = ['medi1', 'medi2', 'medi3', 'medi4'];
  List<String> group2 = ['alegy1', 'alegy2', 'alegy3', 'alegy4', 'alegy5'];
  List<String> group3 = ['food1', 'food2', 'food3', 'food4'];

  List<String> selectedValue = [];

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 370,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    multiple: true,
                    clearable: true,
                    value: selectedValue,
                    onChanged: setSelectedValue,
                    itemCount: group1.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(group1[i]),
                        onSelected: state.onSelected(group1[i]),
                        label: Text(group1[i]),
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
                      'Group1',
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
                  width: 370,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    multiple: true,
                    clearable: true,
                    value: selectedValue,
                    onChanged: setSelectedValue,
                    itemCount: group2.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(group2[i]),
                        onSelected: state.onSelected(group2[i]),
                        label: Text(group2[i]),
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
                      'Group2',
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
                  width: 370,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black, width: 2), // 테두리 스타일 지정
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8)), // 테두리 모서리 둥글게 만듦
                  ),
                  child: Choice<String>.inline(
                    multiple: true,
                    clearable: true,
                    value: selectedValue,
                    onChanged: setSelectedValue,
                    itemCount: group3.length,
                    itemBuilder: (state, i) {
                      return ChoiceChip(
                        selected: state.selected(group3[i]),
                        onSelected: state.onSelected(group3[i]),
                        label: Text(group3[i]),
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
                      'Group3',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(selectedValue.toString()),
        IconButton(
            onPressed: () {
              Navigator.pop(context, selectedValue);
            },
            icon: Icon(Icons.search)),
      ],
    );
  }
}
