import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/controllers/auth_bloc/auth_bloc.dart';
import 'package:sm_app/controllers/user_profile_bloc/user_profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sm_app/utils/navigation_helper.dart';
import 'package:sm_app/views/log_and_sign/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBloc>().add(
          UserProfileGetEvent(),
        );
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserProfileError) {
                return Center(
                  child: Text(state.errorMessege),
                );
              } else if (state is UserProfileLoaded) {
                final userData = state.userProfile;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50.r,
                                backgroundImage: AssetImage(
                                  userData.profilePicture.isEmpty
                                      ? 'assets/login-back.png'
                                      : userData.profilePicture,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () async {
                                    final imageFile = await pickImage();
                                    print(imageFile);
                                    context.read<UserProfileBloc>().add(
                                          UserProfileImageUpdateEvent(
                                            image: imageFile!,
                                            uid: userData.uid,
                                          ),
                                        );
                                    pickImage();
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            userData.username,
                            style: TextStyle(
                              fontSize: 24.w,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    userData.followersCount.toString(),
                                    style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Followers'),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    userData.followingCount.toString(),
                                    style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text('Following'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.black,
                            tabs: [
                              Tab(text: 'Post'),
                              Tab(text: 'Signout'),
                            ],
                          ),
                          SizedBox(
                            height: 400.h,
                            child: TabBarView(
                              children: [
                                const PostItem(),
                                TextButton.icon(
                                  onPressed: () {
                                    try {
                                      context.read<AuthBloc>().add(
                                            AuthSignOutEvent(),
                                          );
                                      NavigationHelper.pushReplacment(
                                        context,
                                        LoginScreen(),
                                      );
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  label: const Text('Signout'),
                                  icon: const Icon(
                                    Icons.settings_power,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text('No Data'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/login-back.png'),
                ),
                title: Text(
                  'Nilesh',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Posted 1h ago'),
              ),
              SizedBox(height: 10.h),
              Text(
                'Discover adventure in patagonia\'s peaks or serenity provence\'s @hamlets - arrival',
                style: TextStyle(fontSize: 16.w),
              ),
              SizedBox(height: 10.h),
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage('assets/login-back.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
