import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/keg_record_page.dart';

class GetKegRecord extends StatelessWidget {

  final String documentId;

  GetKegRecord({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference kegs = FirebaseFirestore.instance.collection('kegs');

    return FutureBuilder<DocumentSnapshot>(
      future: kegs.doc(documentId).get(),
      builder: ((context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return wrappedText(context, data) ;
        }
        return Text('loading...');
      }),
    );
  }

  Widget wrappedText(BuildContext context, data) {


    return Row(
      children: [
        GestureDetector(
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return KegRecordPage(documentId: documentId);
            }
            )
            );
          },
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'k${data['id']}:  '),
                TextSpan(text: '${data['contents']}  ', style: const TextStyle(fontWeight: FontWeight.bold,)),
                TextSpan(text: '${data['status']}', style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.blue)),
              ]
            )
          )
        ),
      ],
    );
  }
}
