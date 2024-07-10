import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/controllers/auth_bloc/auth_bloc.dart';
import 'package:sm_app/services/auth_service.dart';
import 'package:sm_app/utils/color_consts.dart';
import 'package:sm_app/utils/navigation_helper.dart';
import 'package:sm_app/utils/size_consts.dart';
import 'package:sm_app/view/login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final alreadyMessege = ValueNotifier<String>('');
  final isLoading = ValueNotifier<bool>(false);
  final visibilityNotifier = ValueNotifier<bool>(true);

  void toggleVisibility() {
    visibilityNotifier.value = !visibilityNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                        "Please Register!",
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
                      SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder(
                            valueListenable: isLoading,
                            builder: (context, loading, _) {
                              return loading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authSignIn(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: mainBlue,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.h),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Text(
                                        "Register",
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
                      kHight24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Do you have an account?"),
                          TextButton(
                            onPressed: () {
                              NavigationHelper.push(
                                context,
                                LoginScreen(),
                              );
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void authSignIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = true;

    try {
      alreadyMessege.value = '';
      final isEmailAvailable =
          await AuthService().isEmailRegistered(email, password);
      if (isEmailAvailable) {
        if (context.mounted) {
          context.read<AuthBloc>().add(
                AuthSignUpEvent(
                  email: email,
                  password: password,
                ),
              );
          NavigationHelper.push(context, LoginScreen());
        }
      } else {
        alreadyMessege.value = 'The email address is already in use.';
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
