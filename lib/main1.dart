import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchController = TextEditingController();

  List<String> _collections = [];
  bool _isLoading = true;
  String? _selectedCollection;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCollections();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

Future<void> _loadCollections() async {
  setState(() => _isLoading = true);

  try {
    // Get a list of all collection names by fetching a special document
    // that lists all collections (this requires a special setup)
    final snapshot = await _firestore.collection('_collections').doc('list').get();
    
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _collections = data.keys.toList()..sort();
        _isLoading = false;
      });
    } else {
     final Set<String> collections = {'users','appointments'};
      
      setState(() {
        _collections = collections.toList()..sort();
        _isLoading = false;
      });
    }
  } catch (e) {
    _showError('Failed to load collections: ${e.toString()}');
    setState(() => _isLoading = false);
  }
}
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      _showError('Sign out failed: ${e.toString()}');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Firebase Admin'),
        actions: [
          if (user?.email != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Text(user!.email!)),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCollections,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Collections',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Select a collection to view',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _collections.isEmpty
                      ? const Center(child: Text('No collections found'))
                      : ListView.builder(
                          itemCount: _collections.length,
                          itemBuilder: (context, index) {
                            final collection = _collections[index];
                            return ListTile(
                              title: Text(collection),
                              leading: const Icon(Icons.collections),
                              selected: _selectedCollection == collection,
                              onTap: () {
                                setState(() => _selectedCollection = collection);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      body: _selectedCollection == null
          ? const Center(child: Text('Select a collection from the drawer'))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search documents',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () => _searchController.clear(),
                                  )
                                : null,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        tooltip: 'Delete Collection',
                        onPressed: _confirmDeleteCollection,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CollectionView(
                    collectionName: _selectedCollection!,
                    searchQuery: _searchQuery,
                    onCollectionDeleted: () {
                      setState(() => _selectedCollection = null);
                      _loadCollections();
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: _selectedCollection != null
          ? FloatingActionButton(
              onPressed: () => _showAddDocumentDialog(),
              child: const Icon(Icons.add),
              tooltip: 'Add Document',
            )
          : null,
    );
  }

  Future<void> _confirmDeleteCollection() async {
    if (_selectedCollection == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${_selectedCollection!}?'),
        content: const Text('This will delete ALL documents in this collection. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _deleteCollection();
    }
  }

  Future<void> _deleteCollection() async {
    if (_selectedCollection == null) return;

    try {
      final query = await _firestore.collection(_selectedCollection!).get();
      final batch = _firestore.batch();

      for (final doc in query.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      _showSuccess('Collection $_selectedCollection deleted');
      setState(() => _selectedCollection = null);
      _loadCollections();
    } catch (e) {
      _showError('Failed to delete collection: ${e.toString()}');
    }
  }

  void _showAddDocumentDialog() {
    showDialog(
      context: context,
      builder: (context) => AddDocumentDialog(collectionName: _selectedCollection!),
    );
  }
}

class CollectionView extends StatelessWidget {
  final String collectionName;
  final String searchQuery;
  final VoidCallback onCollectionDeleted;

  const CollectionView({
    required this.collectionName,
    required this.searchQuery,
    required this.onCollectionDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return const Center(child: Text('No documents found'));
        }

        final filteredDocs = searchQuery.isEmpty
            ? docs
            : docs.where((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return jsonEncode(data).toLowerCase().contains(searchQuery.toLowerCase()) ||
                    doc.id.toLowerCase().contains(searchQuery.toLowerCase());
              }).toList();

        if (filteredDocs.isEmpty) {
          return Center(child: Text('No matches for "$searchQuery"'));
        }

        return ListView.builder(
          itemCount: filteredDocs.length,
          itemBuilder: (context, index) {
            final doc = filteredDocs[index];
            return DocumentCard(
              collectionName: collectionName,
              documentId: doc.id,
              documentData: doc.data() as Map<String, dynamic>,
              onDocumentDeleted: onCollectionDeleted,
            );
          },
        );
      },
    );
  }
}

class DocumentCard extends StatefulWidget {
  final String collectionName;
  final String documentId;
  final Map<String, dynamic> documentData;
  final VoidCallback onDocumentDeleted;

  const DocumentCard({
    required this.collectionName,
    required this.documentId,
    required this.documentData,
    required this.onDocumentDeleted,
    super.key,
  });

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.documentId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _showEditDialog,
                    tooltip: 'Edit Document',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: _confirmDelete,
                    tooltip: 'Delete Document',
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const Divider(),
                const SizedBox(height: 8),
                ...widget.documentData.entries.map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              entry.key,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                    child: Text(_formatValue(entry.value))),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'null';
    if (value is Timestamp) return value.toDate().toString();
    if (value is Map || value is List) return const JsonEncoder.withIndent('  ').convert(value);
    return value.toString();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${widget.documentId}?'),
        content: const Text('This document will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _deleteDocument();
    }
  }

  Future<void> _deleteDocument() async {
    try {
      await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(widget.documentId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Document ${widget.documentId} deleted')),
      );

      widget.onDocumentDeleted();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => EditDocumentDialog(
        collectionName: widget.collectionName,
        documentId: widget.documentId,
        documentData: widget.documentData,
      ),
    );
  }
}

class AddDocumentDialog extends StatefulWidget {
  final String collectionName;

  const AddDocumentDialog({required this.collectionName, super.key});

  @override
  State<AddDocumentDialog> createState() => _AddDocumentDialogState();
}

class _AddDocumentDialogState extends State<AddDocumentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _documentIdController = TextEditingController();
  final _fields = <MapEntry<TextEditingController, TextEditingController>>[];
  bool _useAutoId = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addField();
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    for (final field in _fields) {
      field.key.dispose();
      field.value.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      _fields.add(MapEntry(
        TextEditingController(),
        TextEditingController(),
      ));
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields[index].key.dispose();
      _fields[index].value.dispose();
      _fields.removeAt(index);
    });
  }

  Future<void> _saveDocument() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final data = <String, dynamic>{};
      for (final field in _fields) {
        final key = field.key.text.trim();
        final value = field.value.text.trim();
        data[key] = _parseValue(value);
      }

      if (_useAutoId) {
        final docRef = await FirebaseFirestore.instance
            .collection(widget.collectionName)
            .add(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Document added with ID: ${docRef.id}')),
        );
      } else {
        await FirebaseFirestore.instance
            .collection(widget.collectionName)
            .doc(_documentIdController.text.trim())
            .set(data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Document added successfully')),
        );
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  dynamic _parseValue(String value) {
    if (value.toLowerCase() == 'true') return true;
    if (value.toLowerCase() == 'false') return false;
    if (value == 'null') return null;
    if (int.tryParse(value) != null) return int.parse(value);
    if (double.tryParse(value) != null) return double.parse(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add to ${widget.collectionName}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _useAutoId,
                    onChanged: (value) => setState(() => _useAutoId = value!),
                  ),
                  const Text('Auto-generated ID'),
                ],
              ),
              if (!_useAutoId)
                TextFormField(
                  controller: _documentIdController,
                  decoration: const InputDecoration(
                    labelText: 'Document ID',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (!_useAutoId && (value == null || value.isEmpty)) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              const Text('Fields:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ..._fields.asMap().entries.map((entry) {
                final index = entry.key;
                final field = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: field.key,
                          decoration: const InputDecoration(
                            labelText: 'Field Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: field.value,
                          decoration: const InputDecoration(
                            labelText: 'Value',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: _fields.length > 1 ? () => _removeField(index) : null,
                      ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: _addField,
                icon: const Icon(Icons.add),
                label: const Text('Add Field'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveDocument,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('SAVE'),
        ),
      ],
    );
  }
}

class EditDocumentDialog extends StatefulWidget {
  final String collectionName;
  final String documentId;
  final Map<String, dynamic> documentData;

  const EditDocumentDialog({
    required this.collectionName,
    required this.documentId,
    required this.documentData,
    super.key,
  });

  @override
  State<EditDocumentDialog> createState() => _EditDocumentDialogState();
}

class _EditDocumentDialogState extends State<EditDocumentDialog> {
  late final List<MapEntry<String, TextEditingController>> _fields;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fields = widget.documentData.entries.map((entry) {
      return MapEntry(
        entry.key,
        TextEditingController(text: _formatValue(entry.value)),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (final field in _fields) {
      field.value.dispose();
    }
    super.dispose();
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'null';
    if (value is Timestamp) return value.toDate().toString();
    if (value is Map || value is List) return const JsonEncoder.withIndent('  ').convert(value);
    return value.toString();
  }

  void _addField() {
    showDialog(
      context: context,
      builder: (context) {
        final keyController = TextEditingController();
        final valueController = TextEditingController();
        return AlertDialog(
          title: const Text('Add New Field'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: keyController,
                decoration: const InputDecoration(
                  labelText: 'Field Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Field Value',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (keyController.text.trim().isNotEmpty) {
                  setState(() {
                    _fields.add(MapEntry(
                      keyController.text.trim(),
                      valueController,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('ADD'),
            ),
          ],
        );
      },
    );
  }

  void _removeField(int index) {
    setState(() {
      _fields[index].value.dispose();
      _fields.removeAt(index);
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);

    try {
      final data = <String, dynamic>{};
      for (final field in _fields) {
        data[field.key] = _parseValue(field.value.text.trim());
      }

      await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(widget.documentId)
          .update(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Document ${widget.documentId} updated')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  dynamic _parseValue(String value) {
    if (value.toLowerCase() == 'true') return true;
    if (value.toLowerCase() == 'false') return false;
    if (value == 'null') return null;
    if (int.tryParse(value) != null) return int.parse(value);
    if (double.tryParse(value) != null) return double.parse(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.documentId}'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._fields.asMap().entries.map((entry) {
                final index = entry.key;
                final fieldName = entry.value.key;
                final controller = entry.value.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              fieldName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeField(index),
                          ),
                        ],
                      ),
                      TextField(
                        controller: controller,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Center(
                child: TextButton.icon(
                  onPressed: _addField,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Field'),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveChanges,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('SAVE'),
        ),
      ],
    );
  }
}