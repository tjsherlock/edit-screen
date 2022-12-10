import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/keg_form_page.dart';
import '../pages/keg_record_page.dart';

class GetKegRecord extends StatelessWidget {
  //const GetUserName({Key? key}) : super(key: key);

  final String documentId;

  GetKegRecord({required this.documentId});


  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference kegs = FirebaseFirestore.instance.collection('kegs');

/*    print(kegs.id);

    return Text(kegs.id.toString());*/

    return FutureBuilder<DocumentSnapshot>(
      future: kegs.doc(documentId).get(),
      builder: ((context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return wrappedText(context, data) ;
/*        return Text('${data['id']}' +
        ' ' + '${data['contents']}' +
        ' ' + '${data['type']}' +
        ' ' + '${data['location']}' +
        ' ' + '${data['status']}' );*/
        }
        return Text('loading...');
      }),
    );
  }

  Widget wrappedText(BuildContext context, data) {


    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              //return KegRecordPage(data: data);
              return KegFormPage();
            }
            )
            );
          },

/*          child: Text('k${data['id']}' + //how to turn into a link to record
              ':  ' + '${data['contents']}'
*//*                    ' ' + '${data['type']}' +
                    ' ' + '${data['location']}' + *//*
                    ', ' + '${data['status']}',// how to make italic?
              style: TextStyle(
                color: Colors.blue,
                //fontWeight: FontWeight.bold,
              )),*/

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

/*    var text = RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'Hello'),
          TextSpan(text: 'World', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );*/




  }

//SizedBox(height: 10),

}
