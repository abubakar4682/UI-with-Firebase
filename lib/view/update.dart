import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
 }

class _UpdateState extends State<Update> {
  DatabaseReference database = FirebaseDatabase.instance.ref('Post');
  final textfieldcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (String value) {
                setState(() {});
              },
              controller: textfieldcontroller,
              decoration: const InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
            ),
            // Expanded(
            //   child: StreamBuilder(
            //     stream: database.onValue,
            //       builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
            //       if(!snapshot.hasData){
            //         return CircularLoaderWidget();
            //       }else{
            //         Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic ;
            //         List < dynamic> list =[] ;
            //         list.clear() ;
            //         list =map.values.toList();
            //         return     ListView.builder(
            //             itemCount: snapshot.data!.snapshot.children.length,
            //             itemBuilder:(context , index){
            //               return ListTile(
            //                 title: Text(list[index]['title']),
            //               );
            //             } );
            //
            //       }
            //
            //
            //   },
            //   ),
            // ),

            Expanded(
              child: FirebaseAnimatedList(
                  query: database,
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = (snapshot
                        .child(
                          'title',
                        )
                        .value
                        .toString());
                    if (textfieldcontroller.text.isEmpty) {
                      return ListTile(
                        subtitle: Text(snapshot.child('id').value.toString()),
                        title: Text(
                          snapshot
                              .child(
                                'title',
                              )
                              .value
                              .toString(),
                          style: const TextStyle(fontSize: 10,color: Colors.cyanAccent),
                        ),
                      );
                    } else if (title.toLowerCase().contains(
                        textfieldcontroller.text.toLowerCase().toLowerCase())) {
                      return ListTile(
                        subtitle: Text(
                          snapshot.child('id').value.toString(),
                          style: const TextStyle(color: Colors.cyanAccent),
                        ),
                        title: Text(
                          snapshot
                              .child(
                                'title',
                              )
                              .value
                              .toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
