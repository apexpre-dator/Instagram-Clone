import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      email: _emailController.text,
      pass: _passController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackbar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenlayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 60),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'data:image/jpeg;base64,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'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 25),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 25),
              TextFieldInput(
                textEditingController: _passController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 25),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: signupUser,
                child: Container(
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text('Sign up'),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text('Already have an account? '),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Log in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
