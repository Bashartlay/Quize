import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tests_system/screens/the_tests.dart';

class NameRegistrationPage extends StatelessWidget {
  const NameRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameHeader(size),
                _buildNameForm(nameController, passwordController),
                SizedBox(height: 20),
                _buildNameButton(context, nameController, passwordController),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildNameHeader(Size size) {
    return Container(
      width: size.width,
      child: Column(
        children: [
          Positioned(
            top: 120,
            left: 120,
            child: Text(
              'Register Your Name',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameForm(TextEditingController nameController, TextEditingController passwordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        _buildTextField(nameController, Icons.person, "Enter your name", false),
        SizedBox(height: 20),
        _buildTextField(passwordController, Icons.lock, "Enter your password", true),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String hintText, bool obscureText) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.amber,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.amber,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.amber,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameButton(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          String name = nameController.text;
          String password = passwordController.text;
          if (name.isNotEmpty && password.isNotEmpty) {
            await GetIt.I<SharedPreferences>().setString('name', name);
            await GetIt.I<SharedPreferences>().setString('password', password);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Name and Password registered successfully'),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TheTests()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please enter a valid name and password'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(202, 255, 192, 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
        ),
        child: Text(
          "Start",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
