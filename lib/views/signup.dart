import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timesheet/widgets/custom_text_field_builder.dart';
import '../viewmodels/signup_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
    final _formKey=GlobalKey<FormState>();
    final nameController = TextEditingController();
    final lastNameController = TextEditingController();
    final matriculeController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    matriculeController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  final signupViewModel = Provider.of<SignupViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 250, 250),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child:Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
             Text(
              'Signup',
              style: GoogleFonts.bonaNova(
               // height: 30,
                color: const Color.fromARGB(255, 166, 36, 36),
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            buildTextField(
              label: 'Name',
              controller: nameController, 
              validator: (value) =>signupViewModel.validateName(value) ,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextField(
              label: 'Last Name',
              controller: lastNameController,
              validator: (value) => signupViewModel.validateLastName(value),

            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextField(
              label: 'Matricule',
              controller: matriculeController,
              validator:(value) => signupViewModel.validateMatricule(value),

            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextField(
              label: 'Email',
              controller: emailController,
              validator:(value) => signupViewModel.validateEmail(value),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextField(
              label: 'Password',
              controller: passwordController,
              obscureText: true,
              validator:(value) => signupViewModel.validatePassword(value),

            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextField(
              label: 'Confirm Password',
              controller: confirmPasswordController,
              validator: (value) => signupViewModel.validateConfirmPassword(passwordController.text, value),
              obscureText: true,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () => _handleSignup(signupViewModel, context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
      ),
    );
  }



  Future<void> _handleSignup(SignupViewModel viewModel, BuildContext context) async {
   if (_formKey.currentState?.validate() ?? false){
    viewModel.name = nameController.text;
    viewModel.lastName = lastNameController.text;
    final matriculeText = matriculeController.text;
    viewModel.email = emailController.text;
    viewModel.password = passwordController.text;

    final confirmPassword = confirmPasswordController.text;

    final passwordError = viewModel.validateConfirmPassword(viewModel.password, confirmPassword);
    if (passwordError != null) {
     _showSnackbar(passwordError); 
     return;
    }
    final matriculeError = viewModel.validateMatricule(matriculeText);
    if (matriculeError != null) {
      _showSnackbar(matriculeError);
      return;
    }
    viewModel.matricule=int.tryParse(matriculeText) ?? 0;

    bool success = await viewModel.signup();
    _showSnackbar(success? 'User successfully signed up' : 'Signup failed : Duplicate email or matricule');

    if (success) {
      _navigateToLogin();
    }
    }
  }


  void _showSnackbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  void _navigateToLogin(){
    Navigator.pushReplacementNamed(context, '/login');
  }

}

