import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KegFormPage extends StatefulWidget {

  const KegFormPage({
    Key? key,
  }): super(key: key);

  @override
  State<KegFormPage> createState() => _KegFormPageState();

}


class _KegFormPageState extends State<KegFormPage> {

  final user = FirebaseAuth.instance.currentUser!;

  final String record = '';

  final _kegIdController = TextEditingController();
  final _contentsController = TextEditingController();
  final _kegTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _statusController = TextEditingController();


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

  }

  @override
  Widget build(BuildContext context) {
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
                      //  'assets/images/image001.jpg',
                      //'assets/images/IntegrityBrewingTransparent_75x75.png',
                      'assets/images/IB_I_Logo_Black_Vector_10PTC.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    //https://stackoverflow.com/questions/50198885/how-to-use-an-image-instead-of-an-icon-in-flutter

/*              Icon(
                  Icons.android,
                  size: 100,
                ),*/

                    //Hello again!
                    SizedBox(height: 10),
                    Text('Keg Tracker',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 52,
                        )
/*              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  ),*/
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
                              child: Text('Add keg',
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