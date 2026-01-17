import 'package:flutter/material.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  String? selectedType;
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Activity')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              items: [
                'Recycling',
                'Walking',
                'Cycling',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => selectedType = value),
              decoration: InputDecoration(labelText: 'Activity type'),
            ),

            SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),

            SizedBox(height: 16),

            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
