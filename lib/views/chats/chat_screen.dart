import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sm_app/utils/color_consts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/login-back.png'),
            ),
            SizedBox(width: 10.w),
            const Text(
              'Close Friend',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.video_call,
              color: mainBlue,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.call,
              color: mainBlue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                ChatBubble(
                  text: 'Hello!!! Dear how are you?',
                  isMe: false,
                  time: '6:32 pm',
                ),
                ChatBubble(
                  text: 'I am fine and you? How can I help you?',
                  isMe: true,
                  time: '6:32 pm',
                ),
                ChatBubble(
                  text:
                      'My work is to analyze flutter trend and also provide guidance for my client, helping them to make profit',
                  isMe: false,
                  time: '6:32 pm',
                ),
                ChatBubble(
                  text: 'Do you know about flutter?',
                  isMe: true,
                  time: '6:32 pm',
                ),
                ChatBubble(
                  text: 'Yes I know flutter.',
                  isMe: false,
                  time: '6:32 pm',
                ),
                ChatBubble(
                  text: 'Don\'t you want to study?',
                  isMe: true,
                  time: '6:32 pm',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: mainBlue),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.image,
                    color: mainBlue,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: mainBlue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0.w,
        vertical: 4.0.h,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  radius: 15.r,
                  backgroundImage: const AssetImage('assets/login-back.png'),
                ),
              if (!isMe) SizedBox(width: 5.w),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 14.w,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? mainBlue : Colors.grey.shade300,
                    borderRadius: isMe
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            bottomLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                            topLeft: Radius.circular(20.r),
                          ),
                  ),
                  child: Text(
                    maxLines: text.length,
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              if (isMe) SizedBox(width: 5.w),
              if (isMe)
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/login-back.png'),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0.h,
            ),
            child: Text(
              time,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
