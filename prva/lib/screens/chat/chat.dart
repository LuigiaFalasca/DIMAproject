import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/screens/house_profile/info_house_profile.dart';
import 'package:prva/screens/personal_profile/all_houses.dart';
import 'package:prva/screens/personal_profile/show_info_personal_profile.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/chat/chat_service.dart';

import '../house_profile/all_profile.dart';

class ChatPage extends StatefulWidget {
  late HouseProfileAdj? withHouse;
  late PersonalProfileAdj? withPerson;
  final String nameReciver;
  final String receiverUserID;
  final String senderUserID;

  ChatPage(
      {super.key,
      required this.nameReciver,
      required this.receiverUserID,
      required this.senderUserID,
      this.withHouse,
      this.withPerson});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService(null);

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.senderUserID, widget.receiverUserID, _messageController.text);
      _messageController.clear();
      //clear the controller after sending the message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          automaticallyImplyLeading:
              MediaQuery.of(context).size.width < widthSize,
          title: InkWell(
            child: Text(
              widget.nameReciver,
              style: GoogleFonts.plusJakartaSans(
                color: backgroundColor,
                fontSize: size24(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              widget.withHouse != null
                  ? showHouseProfile()
                  : showPersonalProfile();
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, widget.senderUserID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }

          if (snapshot.hasData) {
            return ListView(
              reverse: true,
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            );
          } else {
            return const Text('');
          }
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages
    var aligment = (data['senderID'] == widget.senderUserID)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var colorMsg = (data['senderID'] == widget.senderUserID)
        ? const Color.fromARGB(255, 62, 62, 62)
        : mainColor;

    var crossAling = (data['senderID'] == widget.senderUserID)
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment: crossAling,
        children: [
          Container(
            decoration: BoxDecoration(
                color: colorMsg, borderRadius: BorderRadius.circular(25)),
            constraints: BoxConstraints(
              minWidth: MediaQuery.sizeOf(context).height * 0.1,
              maxWidth: MediaQuery.sizeOf(context).height * 0.4,
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Column(crossAxisAlignment: crossAling, children: [
              Text(data['message'],
                  style: TextStyle(
                      fontSize: size16(context), color: backgroundColor)),
              data['timestamp'].toDate().minute >= 10
                  ? Text(
                      "${data['timestamp'].toDate().hour}:${data['timestamp'].toDate().minute}",
                      style: TextStyle(
                          fontSize: size10(context), color: backgroundColor))
                  : Text(
                      "${data['timestamp'].toDate().hour}:0${data['timestamp'].toDate().minute}",
                      style: TextStyle(
                          fontSize: size10(context), color: backgroundColor)),
            ]),
          ),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E3E7),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 30,
              color: backgroundColor,
            ),
          ),
        ),
      ],
    );
  }

  showHouseProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewProfile(
                  houseProfile: widget.withHouse!,
                )));
  }

  showPersonalProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewPersonalProfile(
                  personalProfile: widget.withPerson!,
                )));
  }
}
