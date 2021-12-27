import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:next_class/constants.dart';
import 'package:next_class/widgets/build_classes2.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('wednesday').snapshots();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('wednesday');
  final Stream<QuerySnapshot> classStream = FirebaseFirestore.instance
      .collection(dayname(gCounter))
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Center(
          child: Text(
            "Admin Panel Only",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(a);
            },
          ).toList();
          var dateWOtime = DateFormat('yyyy-MM-dd').format(now);
          var dateWtime = storedocs[0]['time'].toString();
          var finaltime = dateWOtime + " " + dateWtime + ":00";

          var startTime = DateTime.parse(finaltime);
          var addedtime =
              startTime.add(Duration(hours: 1, minutes: 30)).toString();
          var endTime = DateTime.parse(addedtime);

          final currentTime = now;
          List<String> str = [];
          FirebaseFirestore.instance
              .collection(dayname(gCounter))
              .orderBy('time')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              str.add(doc.id.toString());
            }
          });

          if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
          } else {}
          return Column(
            children: const [
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
