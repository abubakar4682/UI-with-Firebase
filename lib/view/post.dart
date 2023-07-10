import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/view/login.dart';
class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
        backgroundColor: Colors.cyanAccent,
        actions: [
          IconButton(
              onPressed: (){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Are you Sure to Logout'),

                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: (){
                      auth.signOut().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }).onError((error, stackTrace) {

                      });

                    },
                    child: const Text('yes'),
                  ),
                ],
              ),
            );
           // auth.signOut().then((value) {
           //   Navigator.push(
           //     context,
           //     MaterialPageRoute(builder: (context) => LoginScreen()),
           //   );
           // }).onError((error, stackTrace) {
           //
           // });

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
