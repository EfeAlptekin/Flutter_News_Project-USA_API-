import 'package:flutter/material.dart';
import 'package:food/views/homepage.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Actions when the login button is pressed
                // Implement login logic here

                // Get the username and password from the TextFormField
                String username = '';
                String password = '';

                // Perform validation, authentication, etc.
                // For example, check if the username and password are correct
                if (username == 'correctUsername' &&
                    password == 'correctPassword') {
                  // If the credentials are correct, navigate to the home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                } else {
                  // If the credentials are incorrect, show an error message or handle accordingly
                  // For example, show a snackbar with an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                    ),
                  );
                  // Go back to the previous page after showing the SnackBar
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Actions when the sign-up button is pressed
                // Implement sign-up logic here
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
