import 'package:fitness/components/food_card.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String? _selectedValue = "Morning"; // Initially, no value is selected

  final List<String> _options = [
    'Morning',
    'Afternoon',
    'Evening',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedValue, // Currently selected value
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
          items: _options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ),
        ResponsiveGridView(items: [FoodCard(),FoodCard()],),
      ],
    );
  }
}


class ResponsiveGridView extends StatelessWidget {
  final List<FoodCard> items;

  ResponsiveGridView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: _getGridDelegate(context),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: Center(
              child: items[index],
            ),
          );
        },
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _getGridDelegate(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 1.0,
      );
    } else if (screenWidth >= 992) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
      );
    } else if (screenWidth >= 768) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      );
    } else {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
      );
    }
  }
}
