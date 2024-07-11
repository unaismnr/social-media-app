import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/services/auth_service.dart';
import 'package:sm_app/utils/color_consts.dart';
import 'package:sm_app/utils/navigation_helper.dart';
import 'package:sm_app/utils/size_consts.dart';
import 'package:sm_app/view/log_and_sign/reset_password.dart';
import 'package:sm_app/view/main/main_screen.dart';
import 'package:sm_app/view/log_and_sign/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  void toggleVisibility() {
    visibilityNotifier.value = !visibilityNotifier.value;
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final alreadyMessege = ValueNotifier<String>('');
  final isLoading = ValueNotifier<bool>(false);
  final visibilityNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Please Login!",
                    style: TextStyle(
                      fontSize: 18.w,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  kHight16,
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      final emailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailValid.hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  kHight16,
                  ValueListenableBuilder(
                      valueListenable: visibilityNotifier,
                      builder: (context, visible, _) {
                        return TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                toggleVisibility();
                              },
                              icon: Icon(visible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          obscureText: visible ? true : false,
                        );
                      }),
                  kHight16,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        NavigationHelper.push(
                          context,
                          ResetPasswordScreen(),
                        );
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: mainBlue),
                      ),
                    ),
                  ),
                  kHight24,
                  SizedBox(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, loading, _) {
                          return loading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      authLogIn(context);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainBlue,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(
                                      fontSize: 18.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                        }),
                  ),
                  ValueListenableBuilder(
                      valueListenable: alreadyMessege,
                      builder: (context, error, _) {
                        return Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        );
                      }),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          NavigationHelper.push(
                            context,
                            RegisterScreen(),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: mainBlue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authLogIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = true;

    try {
      alreadyMessege.value = '';
      await AuthService().loginUserWithEmailAndPassword(email, password);
      if (context.mounted) {
        NavigationHelper.pushReplacment(
          context,
          MainScreen(),
        );
      }
    } catch (e) {
      alreadyMessege.value = 'Wrong login details';
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
