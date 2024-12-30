import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

import '../../domain/entity/blog.dart';

class BlogCard extends StatelessWidget {
  final Color color;
  final Blog blog;

  const BlogCard({
    required this.blog,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Card(
        margin: const EdgeInsets.all(15),
        color: color,
        // Set the background color of the Card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        elevation: 8.0,
        // Increased shadow for a more pronounced effect
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              // Add padding inside the Card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      // Increased font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      // Changed to pure white for better contrast
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Space between title and topics
                  Wrap(
                    spacing: 8.0, // Horizontal space between chips
                    runSpacing: 4.0, // Vertical space between chip rows
                    children: blog.topics.map((topic) {
                      return Chip(
                        label: Text(
                          topic,
                          style: TextStyle(
                            color: color, // Use the card color for text
                            fontWeight: FontWeight.w600, // Slightly bolder text
                          ),
                        ),
                        backgroundColor: color.withOpacity(0.3),
                        // More opaque background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Rounded corners for chips
                        ),
                        elevation: 2.0,
                        // Slight elevation for chips
                        shadowColor: Colors.black26, // Shadow color for chips
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8.0, // Distance from the bottom of the card
              right: 16.0, // Distance from the right of the card
              child: Text(
                '${calculateReadingTime(blog.title)} min',
                // Assuming blog.readingTime is an integer
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors
                      .white70, // Slightly lighter color for the time text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
