import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_state.dart';
import 'package:blog_app/core/common/widgets/my_loader.dart';
import 'package:blog_app/core/constents/constants.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snakbar.dart';
import 'package:blog_app/features/blog/presentation/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import '../../../../core/theme/app_pallete.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());

  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  File? image;
  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    final pickedImage = await pickImageFromMob();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (_formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserSignIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
            userId: userId,
            title: titleController.text.trim(),
            content: blogContentController.text.trim(),
            image: image!,
            topics: selectedTopics,
          ));
    }
  }

  final titleController = TextEditingController();
  final blogContentController = TextEditingController();

  List<String> selectedTopics = [];

  @override
  void dispose() {
    titleController.dispose();
    blogContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: uploadBlog, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const MyLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: const DashedBorder.fromBorderSide(
                                  dashLength: 10,
                                  side: BorderSide(
                                      color: AppPallete.borderColor, width: 2),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Icon(
                                    Icons.folder_open,
                                    size: 45,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Select Your Image",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: Constants.topics
                            .map(
                              (items) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(items)) {
                                      selectedTopics.remove(items);
                                    } else {
                                      selectedTopics.add(items);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    color: selectedTopics.contains(items)
                                        ? const WidgetStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    label: Text(items),
                                    side: selectedTopics.contains(items)
                                        ? null
                                        : const BorderSide(
                                            color: AppPallete.borderColor),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlogEditor(
                        hintText: "Blog Title", controller: titleController),
                    const SizedBox(
                      height: 15,
                    ),
                    BlogEditor(
                        hintText: "Blog content",
                        controller: blogContentController),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
