// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  route() => MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  _AddNewBlogPageState createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final textController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Blog'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DottedBorder(
                  color: AppPallete.borderColor,
                  dashPattern: const [10, 4],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        ['Technology', 'Business', 'Programming', 'Design']
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
                                              color: AppPallete.borderColor),
                                    ),
                                  ),
                                ))
                            .toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlogEditor(controller: textController, hintText: 'Blog Title'),
                const SizedBox(
                  height: 10,
                ),
                BlogEditor(
                    controller: contentController, hintText: 'Blog Content')
              ],
            ),
          ),
        ));
  }
}
