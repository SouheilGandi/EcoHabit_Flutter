import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import '../widgets/custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 250),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset('assets/advancia1.png'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 166, 36, 36),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  CustomTextField(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ElevatedButton(
                    onPressed: () =>_handleSignIn(context, loginViewModel),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text(
                    "You don't have an account? Signup",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext context,LoginViewModel viewModel) async{
   viewModel.email = emailController.text;
   viewModel.password = passwordController.text;
   bool success = await viewModel.login();

    if (success) {
      _navigateToForm(); 
      _showSnackbar('Login Successful');
    } else {
      _showSnackbar('Login Failed: Incorrect Email or Password');
    }

  }

    void _showSnackbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  void _navigateToForm(){
    Navigator.pushReplacementNamed(context, '/form');
  }

}
