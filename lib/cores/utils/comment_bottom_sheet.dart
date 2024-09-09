import 'package:flutter/material.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';

void commentBottomSheet(
    BuildContext context, TextEditingController commentController) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppPallete.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    const Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.info))
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(4),
                          child: const Text('data'));
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        inputDecorationTheme: const InputDecorationTheme()),
                    child: TextFormField(
                      controller: commentController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: 'Enter the comment',
                        suffix: TextButton(
                          onPressed: () {},
                          child: const Text('Next'),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
