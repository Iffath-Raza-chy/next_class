import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildClasses2 extends StatefulWidget {
  const BuildClasses2({Key? key}) : super(key: key);

  @override
  _BuildClasses2State createState() => _BuildClasses2State();
}

class _BuildClasses2State extends State<BuildClasses2> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('classes').snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: studentsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            return Column(
              children: List.generate(storedocs.length, (index) {
                return Column(
                  children: List.generate(storedocs[index].length, (index2) {
                    return Text(storedocs[index]['1']['sub'].toString());
                  }),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
//Text(storedocs[index]['1']['sub'].toString());