import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class JobService {
  static Future<List<Jobs>> getJobs() async {
    final response = await http.get(Uri.parse('https://jobicy.com/api/v2/remote-jobs'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body)['data'];
      return jsonData.map((e) => Jobs.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Jobs');
    }
  }
}
