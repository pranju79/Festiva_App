import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class UsersData extends StatefulWidget {
  const UsersData({super.key});

  @override
  _UsersDataState createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<void> _updateUser(DocumentSnapshot doc) async {
    // Implement your update logic here
  }

  Future<void> _deleteUser(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection('UserRegister')
        .doc(doc.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: const Text(
          'Users Data',
          style: TextStyle(color: TTColors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search by Name',
                  fillColor: TTColors.light,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('UserRegister')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      final name = (doc.data() as Map<String, dynamic>)['Name']
                              ?.toString()
                              .toLowerCase() ??
                          '';
                      return name.contains(_searchQuery);
                    }).toList();

                    return ListView(
                      children: filteredDocs.map((doc) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${(doc.data() as Map<String, dynamic>).containsKey('Name') ? doc['Name'] : 'N/A'}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Email: ${(doc.data() as Map<String, dynamic>).containsKey('Email') ? doc['Email'] : 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Mobile No: ${(doc.data() as Map<String, dynamic>).containsKey('MobileNo') ? doc['MobileNo'] : 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Gender: ${(doc.data() as Map<String, dynamic>).containsKey('gender') ? doc['gender'] : 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Edit'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: TTColors.white,
                                        backgroundColor: TTColors.blue,
                                      ),
                                      onPressed: () {
                                        _updateUser(doc);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.delete),
                                      label: const Text('Delete'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: TTColors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        _deleteUser(doc);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
