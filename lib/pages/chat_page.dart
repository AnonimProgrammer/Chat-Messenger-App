import 'package:chat_messenger_app/chat_components/message_tile.dart';
import 'package:chat_messenger_app/chat_components/send_message_button.dart';
import 'package:chat_messenger_app/components/my_textfield.dart';
import 'package:chat_messenger_app/services/authentication.dart';
import 'package:chat_messenger_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // for textfiel focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // cause a delay so that the keyboard has time to show up
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  // scroll down method
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message method
  void sendMessage() async {
    // if message is not empty
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatServices.sendMessage(
          widget.receiverID, _messageController.text);

      // clear controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.receiverEmail,
        ),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input field
          _buildUserInput(context),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessage(senderID, widget.receiverID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return const Text('Error in StreamBuilder!');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        // return list view
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc, context))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    // align message right if sender is current user, otherwise align left
    Alignment messageAlignment =
        (isCurrentUser) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: messageAlignment,
      child: MessageTile(
        messageText: data["message"],
        isCurrentUser: isCurrentUser,
      ),
    );
  }

  // build user input
  Widget _buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35),
      child: Row(
        children: [
          // textfield takes most of the space
          Expanded(
            child: MyTextfield(
              textController: _messageController,
              hintText: "Type a message...",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          // send message button
          SendMessageButton(onPressed: sendMessage),
        ],
      ),
    );
  }
}
