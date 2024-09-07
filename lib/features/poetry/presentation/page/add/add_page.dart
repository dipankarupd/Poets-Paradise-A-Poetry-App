import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poets_paradise/cores/palette/app_palette.dart';
import 'package:poets_paradise/cores/utils/choose_image.dart';
import 'package:poets_paradise/cores/utils/loader.dart';
import 'package:poets_paradise/cores/utils/poetry_categories.dart';
import 'package:poets_paradise/cores/utils/show_snackbar.dart';
import 'package:poets_paradise/features/poetry/presentation/bloc/poetry_bloc.dart';
import 'package:poets_paradise/features/poetry/presentation/widget/poetry_textfields.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController poetryController = TextEditingController();

  // final auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  File? image;

  List<String> selectedItems = [];

  void _addImage() async {
    final pickedImage = await chooseImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void _resetForm() {
    image = null;
    selectedItems.clear();
    titleController.clear();
    poetryController.clear();
    formKey.currentState?.reset();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PoetryBloc>().add(PoetryInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PoetryBloc, PoetryState>(
      listener: (context, state) {
        if (state is PoetryFailedState) {
          return showSnackbar(context, state.message);
        } else if (state is PoetryUploadSuccessState) {
          showSnackbar(context, 'poetry uploaded successfully');
          _resetForm();
          context.read<PoetryBloc>().add(PoetryInitialEvent());
        }
      },
      builder: (context, state) {
        if (state is PoetryUploadingState) {
          return const Loader();
        } else if (state is PoetryInitialState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppPallete.backgroundColor,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
              title: const Text('New Post'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() &&
                        selectedItems.isNotEmpty &&
                        image != null) {
                      context.read<PoetryBloc>().add(
                            PoetryUploadPoemEvent(
                              image: image!,
                              author: state.profile,
                              title: titleController.text.trim(),
                              content: poetryController.text.trim(),
                              categories: selectedItems,
                              likes: [],
                              comments: [],
                              createdAt: DateTime.now(),
                            ),
                          );
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image != null
                            ? GestureDetector(
                                onTap: () => _addImage(),
                                child: SizedBox(
                                  width: 280,
                                  height: 380,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => _addImage(),
                                child: DottedBorder(
                                  strokeWidth: 8,
                                  radius: const Radius.circular(16),
                                  color: AppPallete.greyColor,
                                  child: Container(
                                    width: 280,
                                    height: 380,
                                    color: Colors.grey[100],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.folder_open,
                                            size: 40,
                                          ),
                                        ),
                                        const Text(
                                          'Upload an image',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Upload your poetry below:',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: getCategoriesList()
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedItems.contains(e)
                                            ? selectedItems.remove(e)
                                            : selectedItems.add(e);
                                        setState(() {});
                                      },
                                      child: Chip(
                                        label: Text(
                                          e,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: selectedItems.contains(e)
                                            ? const WidgetStatePropertyAll(
                                                AppPallete.purpleColor)
                                            : const WidgetStatePropertyAll(
                                                AppPallete.greyColor),
                                        side: const BorderSide(
                                            color: AppPallete.borderColor),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        PoetryTextfields(
                          controller: titleController,
                          label: 'Enter the poetry title',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PoetryTextfields(
                          controller: poetryController,
                          label: 'Enter the poetry here',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else
          return Scaffold();
      },
    );
  }
}
