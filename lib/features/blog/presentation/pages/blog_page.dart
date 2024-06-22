import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  route() => MaterialPageRoute(builder: (context) => const BlogPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Page'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.of(context).push(const AddNewBlogPage().route());
            },
          )
        ],
      ),
      body: const Center(
        child: Text('This is the blog page'),
      ),
    );
  }
}
