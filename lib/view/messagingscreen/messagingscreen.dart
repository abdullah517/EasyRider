import 'package:flutter/material.dart';
import 'package:ridemate/utils/appcolors.dart';
import 'package:ridemate/view/Authentication/components/customappbar.dart';

class ChatScreen extends StatelessWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(context,
          title: title, backgroundColor: Colors.transparent),
      body: const ChatBody(),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            children: const [
              MessageBubble(
                message: 'Hey there!',
                time: '11:30 AM',
                isMe: false,
              ),
              MessageBubble(
                message: 'Hi! How are you?',
                time: '11:32 AM',
                isMe: true,
              ),
              MessageBubble(
                message: 'Hi! How are you?',
                time: '11:32 AM',
                isMe: false,
              ),
              MessageBubble(
                message: 'Hi! How are you?',
                time: '11:32 AM',
                isMe: true,
              ),
              // Add more messages here
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Appcolors.primaryColor,
                ),
                onPressed: () {
                  // Plus icon functionality
                },
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Appcolors.primaryColor,
                        ),
                        onPressed: () {
                          // Emoji button functionality
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Transform.rotate(
                angle: -0.9,
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Appcolors.primaryColor,
                  ),
                  onPressed: () {
                    // Send message functionality
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0), // Add space under the text field
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Appcolors
                    .primaryColor, // Set boundary color to the desired color
                width: 2, // Adjust the width of the boundary
              ),
            ),
            child: const CircleAvatar(
              backgroundColor: Appcolors.primaryColor,
              foregroundColor: Colors.black,
              child: Icon(
                Icons.person,
              ),
            ),
          ),
        const SizedBox(
          width: 8.0,
        ), // Add space between avatar and text container
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isMe ? Appcolors.primary100 : Colors.grey[300],
            borderRadius: BorderRadius.circular(16.0),
            border: isMe
                ? Border.all(color: Appcolors.primaryColor, width: 2)
                : null, // Add border only for isMe container
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.black,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.0,
                  color: isMe ? Colors.black : Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8.0,
        ), // Add space between text container and avatar
        if (isMe)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Appcolors
                    .primaryColor, // Set boundary color to the desired color
                width: 2, // Adjust the width of the boundary
              ),
            ),
            child: const CircleAvatar(
              backgroundColor: Appcolors.primaryColor,
              foregroundColor: Colors.black,
              child: Icon(Icons.person),
            ),
          ),
      ],
    );
  }
}
