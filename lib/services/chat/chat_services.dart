import 'package:chat_messenger_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get instance of AuthService
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /* get user stream
  List<Map<String, dynamic>> = [
    {
      'email' : test@gmail.com,
      'password' : 12345,
      'id' : ..,
    },
    {
      'email' : test1@gmail.com,
      'password' : 98765,
      'id' : ..,
    }
  ]
  */
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          // go through each user
          final user = doc.data();

          // return user;
          return user;
        }).toList();
      },
    );
  }

  // send message
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      message: message,
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      timestamp: timestamp,
    );
    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort the ids (ensures the chatRoomID is the same for any 2 user)
    String chatRoomID = ids.join('_');

    // add new message to database
    // we add each corresponding message to each corresponding chat_room
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessage(String userID, String otherUserID) {
    // construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
