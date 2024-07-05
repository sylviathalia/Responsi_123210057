import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Jobs>> _futureJobs;

  @override
  void initState() {
    super.initState();
    _futureJobs = JobService.getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<List<Jobs>>(
        future: _futureJobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) { // Added null check
            return Center(child: Text('No data available'));
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
