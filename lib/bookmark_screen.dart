import 'package:flutter/material.dart';
import '../services/bookmark_service.dart';
import '../models/job_model.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<Jobs>> _futureBookmarks;

  @override
  void initState() {
    super.initState();
    _futureBookmarks = BookmarkService.getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: FutureBuilder<List<Jobs>>(
        future: _futureBookmarks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Jobs job = snapshot.data![index];
                return ListTile(
                  title: Text(job.jobTitle ?? ''),
                  subtitle: Text(job.companyName ?? ''),
                  onTap: () {
                    // Navigate to job detail page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
