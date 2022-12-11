import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KegRecordPage extends StatefulWidget {

  final String documentId;
  const KegRecordPage({
    Key? key,
    required this.documentId,
  }): super(key: key);

  @override
  State<KegRecordPage> createState() => _KegRecordPageState(documentId: this.documentId);

}


class _KegRecordPageState extends State<KegRecordPage> {

  final user = FirebaseAuth.instance.currentUser!;

  final String record = '';

  final _kegIdController = TextEditingController();
  final _contentsController = TextEditingController();
  final _kegTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _statusController = TextEditingController();

  final String documentId;

  _KegRecordPageState({required this.documentId});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  dispose() {
    _kegIdController.dispose();
    _contentsController.dispose();
    _kegTypeController.dispose();
    _locationController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future addKeg() async {
    //check if user has permission to add a key
    // TODO


    final kegRecord = 'keg:' +  _kegIdController.text.trim();
    await FirebaseFirestore.instance.collection('kegs').doc(
        kegRecord).set({
      'id': _kegIdController.text.trim(),
      'contents': _contentsController.text.trim(),
      'type': _kegTypeController.text.trim(),
      'location': _locationController.text.trim(),
      'status': _statusController.text.trim(),
    }).then((value) => null);
  }


  Future showKeg(String kRecord) async {

    final String kegRecord = kRecord;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(kegRecord).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      _kegIdController.value = data?['id'];// <-- The value you want to retrieve.
      _contentsController.value = data?['contents'];
      _kegTypeController.value = data?['type'];
      _locationController.value = data?['location'];
      _statusController.value = data?['status'];
      // Call setState if needed.
    }

  }


//permissions table?
//collection: permissions
//doc = userid
//map
// {
//   create : false,
//   read : false,
//   update : false,
//   delete: false
// }
//
//

  Future<bool> permissionCreationConfirmed(User user) async {

    CollectionReference permissions = FirebaseFirestore.instance.collection('permissions');
    DocumentReference userPermissions = permissions.doc(user.uid);
    //final snapshot = await userPermissions.get();
    final snapshot = await userPermissions.get();

    if(snapshot.exists) {
      return snapshot.get('create');
    } else {
      return false;
    }
    //if(_user.hasPermission('creation') {

  }

  @override
  Widget build(BuildContext context) {

    //final String documentId;

    //get the collection
    CollectionReference kegs = FirebaseFirestore.instance.collection('kegs');

    return FutureBuilder<DocumentSnapshot>(
      future: kegs.doc(this.documentId).get(),
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

  @override
  Widget wrappedText(BuildContext context, data) {
    _kegIdController.text = data['id'];
    _contentsController.text = data['contents'];
    _kegTypeController.text = data['type'];
    _statusController.text = data['status'];
    _locationController.text = data['location'];

    //_contentsController.value = data['contents'];

    return Scaffold(
        backgroundColor: Colors.grey[300],
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
        body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Put Integrity Brewing icon here.
                    Image.asset(
                      'assets/images/IB_I_Logo_Black_Vector_10PTC.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    //https://stackoverflow.com/questions/50198885/how-to-use-an-image-instead-of-an-icon-in-flutter

                    SizedBox(height: 10),
                    Text('Keg Tracker',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 52,
                        )
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Create a keg record.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height:50),

                    //First Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: _kegIdController,
                              autofocus: false,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText:'Keg Id',
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //Last Name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: _contentsController,
                              autofocus: false,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText:'Contents',
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),


                    //Age
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: _kegTypeController,
                              autofocus: false,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText:'Type',
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //status textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: _statusController,
                              autofocus: false,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText:'Status',
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //location textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                              controller: _locationController,
                              //obscureText: true,
                              decoration:InputDecoration(
                                border: InputBorder.none,
                                hintText:'location',
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: addKeg,
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Center(
                              child: Text('Update keg record',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
            )
        ));
  }



}