import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entity/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) => MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog,));
  const BlogViewerPage({required this.blog,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
              const SizedBox(height: 25,),
              Text(
                blog.userName!,
              style:const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),
              ),
              Text('${formatDateBydMMMYYYY(blog.updatedAt)}  ~~~ ${calculateReadingTime(blog.content)} min'),
              const SizedBox(height : 15),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imgUrl,
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),
              const SizedBox(height : 15),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(blog.content, style: const TextStyle(
                  fontSize: 16,
                  height: 2
                ),),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}
