import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keg_tracker_2/read_data/get_keg_record.dart';
import 'package:keg_tracker_2/read_data/get_user_name.dart';
//import 'package:keg_tracker_2/pages/keg_record_page.dart';

import 'keg_form_page.dart';
import 'keg_record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  //Document Ids
  List<String> docIds = [];

  //Document Ids
  List<String> kegIds = [];

  //get docIds
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection("users").orderBy('age', descending: false ).where('age', isGreaterThan: 30).get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIds.add(document.reference.id);
            },
          ),
        );
  }

  //get KegIds
  Future getKegIds() async {
    //await FirebaseFirestore.instance.collection("kegs").orderBy('id', descending: false ).where('age', isGreaterThan: 30).get().then(

    await FirebaseFirestore.instance.collection("kegs").orderBy('id', descending: false ).get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
          print(document.reference);
          kegIds.add(document.reference.id);
        },
      ),
    );
  }



  @override
  void initState() {
    //getDocIds();
    super.initState();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.email!,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout),
          )
        ]
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Text('Signed in as: ' + user.email!),
              /*MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                color: Colors.deepPurple[200],
                child: Text('sign out'),
              ),*/
    /*          Expanded(
                child: FutureBuilder(
                  future: getDocIds(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            //title: Text(docIds[index]),
                            title: GetUserName(documentId: docIds[index]),
                            tileColor: Colors.grey[200],
                          ),
                        );
                      },
                    );
                  },
                )
              ),*/

              SizedBox(height: 10),

              Expanded(
                  child: FutureBuilder(
                    future: getKegIds(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: kegIds.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              //title: Text(docIds[index]),
                              title: GetKegRecord(documentId: kegIds[index]),
                              tileColor: Colors.grey[200],
                            ),
                          );
                        },
                      );
                    },
                  )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return KegFormPage();
                          // return KegRecordPage(documentId: '',);
                        }));
                      },
                      child: Text('Create keg record',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          )),
    );
  }
}