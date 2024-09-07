import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';

class PopularPoetryCard extends StatelessWidget {
  const PopularPoetryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/poetry.jpg',

                fit: BoxFit.cover, // Ensure image fits well
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    child: const Text(
                      'In the wonderful world who cares what to do I dont know',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 220,
                    child: const Text(
                      'Author',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Read',
                      style: TextStyle(
                          color: AppPallete.purpleColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
