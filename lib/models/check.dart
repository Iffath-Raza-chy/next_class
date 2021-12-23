// List<String> str = [];
//             FirebaseFirestore.instance
//                 .collection(dayname())
//                 .orderBy('time')
//                 .get()
//                 .then((QuerySnapshot querySnapshot) {
//               for (var doc in querySnapshot.docs) {
//                 str.add(doc.id.toString());
//               }
//               print(str[index]);
//             });