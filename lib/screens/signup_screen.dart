import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/resources/auth_methods.dart';
import 'package:instaclone/responsive/mobile_screen_Layout.dart';
import 'package:instaclone/responsive/web_screen_Layout.dart';
import 'package:instaclone/utils/colors.dart';
import 'package:instaclone/utils/utils.dart';
import 'package:instaclone/widgets/buildLogo.dart';
import 'package:instaclone/widgets/text_filed_input.dart';

import '../responsive/responsive_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      userName: _userNameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      //If Signup is not successfull then we have to show a snackbar
      //Here is the snackbar feature--> we use snackbar in the app on various occassions so i have created a different file for snackbar

      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ),
      ));
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //checking if the keyboard is open or not?
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //SVG logo Image
              if (!isKeyboard) const BuildLogo(),

              const SizedBox(
                height: 44,
              ),

              //here we will accept circular avatar from user to slect a profile pic

              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 58,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 58,
                          backgroundImage: NetworkImage(
                              'https://cdn.dribbble.com/users/6142/screenshots/5679189/media/1b96ad1f07feee81fa83c877a1e350ce.png?compress=1&resize=400x300'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () {
                          //image picker here
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo),
                      ))
                ],
              ),

              const SizedBox(
                height: 34,
              ),

              //textField for username

              TextFieldInput(
                textEditingController: _userNameController,
                hintText: "Enter your UserName",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),

              //textField for Bio
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),

              //textField for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your E-mail",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              //textFiled for password
              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter your Bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),

              // Button For Login

              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : const Text("Signup"),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),

              //Transition for signup

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Already Have an Account?"),
                  ),
                  GestureDetector(
                    onTap: () {
                      // on tap Action😎
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Login Now",
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
