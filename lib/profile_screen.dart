import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, String>?> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = AuthService.getUser(); // Retrieve user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, String>?>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text('Error: Unable to load user data');
            } else {
              String username = snapshot.data!['username'] ?? '';
              String password = snapshot.data!['password'] ?? '';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Username: $username'),
                  SizedBox(height: 10),
                  Text('Password: $password'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Logout user
                      AuthService.clearUser();
                      // Navigate to login screen
                    },
                    child: Text('Logout'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
