// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/utlis/show_snack_bar.dart';
import 'package:blog_app/core/common/widgets/loading.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  route() => MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  _AddNewBlogPageState createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final textController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Blog'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user
                        .id;
                if (formKey.currentState!.validate() &&
                    selectedTopics.isNotEmpty &&
                    image != null) {
                  context.read<BlogBloc>().add(BlogUpload(
                      posterId: posterId,
                      title: textController.text.trim(),
                      content: contentController.text.trim(),
                      image: image!,
                      topics: selectedTopics));
                }
              },
            )
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogError) {
              showSnackBar(context, state.message);
            } else if (state is BlogLoaded) {
              Navigator.pushAndRemoveUntil(
                context,
                const BlogPage().route(),
                (route) => false,
              );
              showSnackBar(context, 'succesful');
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        image != null
                            ? GestureDetector(
                                onTap: selectImage,
                                child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              )
                            : GestureDetector(
                                onTap: () {
                                  selectImage();
                                },
                                child: DottedBorder(
                                  color: AppPallete.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  strokeCap: StrokeCap.round,
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open,
                                          size: 40,
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'Select your image',
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              'Technology',
                              'Business',
                              'Programming',
                              'Design'
                            ]
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedTopics.contains(e)) {
                                            selectedTopics.remove(e);
                                          } else {
                                            selectedTopics.add(e);
                                          }
                                          setState(() {});
                                        },
                                        child: Chip(
                                          label: Text(e),
                                          color: selectedTopics.contains(e)
                                              ? const MaterialStatePropertyAll(
                                                  AppPallete.gradient1)
                                              : null,
                                          side: selectedTopics.contains(e)
                                              ? null
                                              : const BorderSide(
                                                  color:
                                                      AppPallete.borderColor),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlogEditor(
                            controller: textController, hintText: 'Blog Title'),
                        const SizedBox(
                          height: 10,
                        ),
                        BlogEditor(
                            controller: contentController,
                            hintText: 'Blog Content')
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}
