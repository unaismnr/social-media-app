import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/utils/color_consts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/login-back.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Text(
                'Discover',
                style: TextStyle(
                  fontSize: 30.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SizedBox(
                height: 120.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    StoryItem(isAdd: true),
                    StoryItem(),
                    StoryItem(),
                    StoryItem(),
                    StoryItem(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Text(
                'Recently Post',
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const PostItem(),
            const PostItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainBlue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  final bool isAdd;

  const StoryItem({super.key, this.isAdd = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
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
          SizedBox(height: 8.h),
          Text(
            isAdd ? 'Your Story' : 'Friend',
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
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.h,
        vertical: 8.0.h,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
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
