import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/controllers/auth_bloc/auth_bloc.dart';
import 'package:sm_app/utils/color_consts.dart';
import 'package:sm_app/utils/size_consts.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  final emailController = TextEditingController();
  final isLoading = ValueNotifier<bool>(false);

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
                    "Send Reset Email!",
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
                                      authSendResetEmail(context);
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
                                    "Send email",
                                    style: TextStyle(
                                      fontSize: 18.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authSendResetEmail(BuildContext context) async {
    final email = emailController.text.trim();

    isLoading.value = true;

    try {
      context.read<AuthBloc>().add(
            AuthSendResetEmail(email: email),
          );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: mainBlue,
            content: Text('Password reset email sent to your email'),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
