import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_orientation_app/utils/components/tt_colors.dart';
import 'package:flutter/material.dart';

class AdminData extends StatefulWidget {
  const AdminData({super.key});

  @override
  _AdminDataState createState() => _AdminDataState();
}

class _AdminDataState extends State<AdminData> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  Future<void> _deleteUser(DocumentSnapshot doc) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this admin?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await FirebaseFirestore.instance
          .collection('admin_register')
          .doc(doc.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Admin deleted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: TTColors.white,
        title: const Text(
          'Admin Data',
          style: TextStyle(color: Colors.white),
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
                      .collection('admin_register')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      final name = (doc.data() as Map<String, dynamic>)['name']
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
                                  'Name: ${(doc.data() as Map<String, dynamic>).containsKey('name') ? doc['name'] : 'N/A'}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Email: ${(doc.data() as Map<String, dynamic>).containsKey('email') ? doc['email'] : 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Mobile No: ${(doc.data() as Map<String, dynamic>).containsKey('mobileno') ? doc['mobileno'] : 'N/A'}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: TTColors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        _deleteUser(doc);
                                      },
                                      child: const Icon(Icons.delete),
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
