import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:migo/controller/simple_ui_controller.dart';
import 'package:migo/view/auth/login.dart';
import 'package:migo/view/products/main/product_page.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/buttons.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController storeIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    storeIDController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.put(SimpleUIController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Responsive(
            desktop: _buildLargeScreen(size, simpleUIController),
            mobile: _buildSmallScreen(size, simpleUIController),
          ),
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildMainBody(
            size,
            simpleUIController,
          ),
        ),
        Expanded(
          child: Image.asset(
            'assets/side_image.png',
            height: size.height * 1,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(
              'assets/migo_logo.png',
              width: size.width / 2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Lets create an account😀',
              style: TextStyle(
                fontSize: size.height * 0.030,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username or Gmail
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    controller: usernameController,

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// StoreID
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.shop),
                      hintText: 'StoreID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    controller: storeIDController,

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Store ID';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// password
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText: simpleUIController.isObscure.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 7) {
                          return 'at least enter 6 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// password
                  Obx(
                    () => TextFormField(
                      controller: confirmPasswordController,
                      obscureText: simpleUIController.isObscure.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        hintText: 'Confirm Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'The password must be same';
                        }
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 7) {
                          return 'at least enter 6 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Login Button
                  PrimaryButton(
                    vertPad: 20,
                    buttonTitle: "Create Admin account",
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // ... Navigate To your Home Page
                        Get.to(() => const ProductsPage());
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      usernameController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      storeIDController.clear();
                      _formKey.currentState?.reset();
                      simpleUIController.isObscure.value = true;
                      Get.to(() => const LoginView());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        children: [
                          TextSpan(
                              text: " Log in",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
