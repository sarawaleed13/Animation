import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSignUpPage = true;

  void _switchToShoppingPage() {
    setState(() {
      _showSignUpPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Shopping Page
            AnimatedOpacity(
              opacity: _showSignUpPage ? 0.0 : 1.0,
              duration: Duration(milliseconds: 500),
              child: ShoppingPage(),
            ),

            // Sign Up Page
            AnimatedOpacity(
              opacity: _showSignUpPage ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: SignUpPage(onSignUpComplete: _switchToShoppingPage),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final VoidCallback onSignUpComplete;

  SignUpPage({required this.onSignUpComplete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showSuccessDialog(context);
        },
        child: Text("Sign Up"),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sign Up Successful"),
          content: Text("Welcome to the shopping app!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onSignUpComplete(); // Start fade transition
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Welcome to Shopping Page!", style: TextStyle(fontSize: 24)),
    );
  }
}
// void _navigateToShoppingPage(BuildContext context) {
//   Navigator.of(context).push(
//     PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => ShoppingPage(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return FadeTransition(
//           opacity: animation,
//           child: child,
//         );
//       },
//     ),
//   );
// }


// TextButton(
//   onPressed: () {
//     Navigator.of(context).pop();
//     _navigateToShoppingPage(context);
//   },
//   child: Text("Close"),
// ),
