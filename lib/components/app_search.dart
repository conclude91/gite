import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class AppSearch extends StatelessWidget {
  const AppSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.disable,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.disable),
        ),
        hintText: 'Search...',
        hintStyle: TextStyle(color: AppColors.dark),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Align(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            heightFactor: 10,
            child: Icon(
              Icons.search,
              color: AppColors.dark,
            ),
          ),
        ),
      ),
      style: TextStyle(color: AppColors.dark),
      cursorHeight: 18,
      textAlignVertical: TextAlignVertical.bottom,
    );
  }
}
