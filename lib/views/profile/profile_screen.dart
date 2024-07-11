import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_app/controllers/user_profile_bloc/user_profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserProfileBloc>().add(
          UserProfileGetEvent(),
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(color: Colors.black),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
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
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(userData.profilePicture),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          userData.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '36',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text('Post'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  userData.followersCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
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
                                  style: const TextStyle(
                                    fontSize: 20,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          StoryHighlightItem(isAdd: true),
                          StoryHighlightItem(),
                          StoryHighlightItem(),
                          StoryHighlightItem(),
                          StoryHighlightItem(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DefaultTabController(
                    length: 1,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.black,
                          tabs: [
                            Tab(text: 'Post'),
                          ],
                        ),
                        SizedBox(
                          height: 400,
                          child: TabBarView(
                            children: [
                              ListView(
                                children: const [
                                  PostItem(),
                                ],
                              ),
                              const Center(child: Text('Mention')),
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
    );
  }
}

class StoryHighlightItem extends StatelessWidget {
  final bool isAdd;

  const StoryHighlightItem({super.key, this.isAdd = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 3),
              image: DecorationImage(
                image: isAdd
                    ? const AssetImage('assets/login-back.png')
                    : const AssetImage('assets/login-back.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isAdd ? 'Add Story' : 'Highlight',
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                subtitle: Text('Posted in u8s - 1h ago'),
              ),
              const SizedBox(height: 10),
              const Text(
                'Discover adventure in patagonia\'s peaks or serenity provence\'s @hamlets - arrival',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
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
