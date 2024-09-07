import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Adjusted height to better fit the search bar
      child: TextField(
        decoration: InputDecoration(
          labelText:
              'Search..', // Label text displayed above the field // Placeholder inside the field
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide(
              color: AppPallete.borderColor,
              width: 0.8,
            ),
          ),
          filled: true, // Ensure the background is filled
          fillColor:
              AppPallete.backgroundColor, // Match the theme's background color
        ),
      ),
    );
  }
}
