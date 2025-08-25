import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/components/navigationBar.dart';
import 'package:trackncheck/controller/ExpiryController.dart';
import 'package:trackncheck/reminder_list.dart';
import 'package:trackncheck/services/NotificationService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Setexpiry extends StatefulWidget {
  const Setexpiry({super.key});

  @override
  State<Setexpiry> createState() => _SetexpiryState();
}

class _SetexpiryState extends State<Setexpiry> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final NotificationService _notificationService = NotificationService();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _expiryDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
Future<void> saveReminder() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to save reminders')),
      );
      return;
    }

    // Save reminder to Firestore (or your DB)
    await Expirycontroller.saveExpiryReminder(
      productName: _productNameController.text,
      expiryDate: selectedDate!,
    );

    // ✅ Trigger immediate notification
    await _notificationService.scheduleImmediateNotification(
      productName: _productNameController.text,
      expiryDate: selectedDate!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder saved successfully!')),
    );

    Get.offAll(Navigationbar());

    // Clear inputs
    _productNameController.clear();
    _expiryDateController.clear();
    selectedDate = null;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save: $e')),
    );
  }
}


  Future<void> _testNotification() async {
    await _notificationService.testNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleWidget(fontsize: 30, text: 'STORE EXPIRY DATE'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                width: 450,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorConstants.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstants.fieldsColor,
                      blurRadius: 4,
                      offset: Offset(4, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Product Name Field
                    Inputfields(
                      controller: _productNameController,
                      emptyFields: "Please enter product name",
                      icon: Icons.production_quantity_limits_sharp,
                      hintText: 'Product name',
                    ),
                    const SizedBox(height: 16),

                    // Expiry Date Field
                    GestureDetector(
                      onTap: () => _pickDate(context),
                      child: AbsorbPointer(
                        child: Inputfields(
                          controller: _expiryDateController,
                          emptyFields: "Please select expiry date",
                          icon: Icons.date_range,
                          hintText: 'Expiry date',
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        text: "Save Reminder",
                        onPressed: () {
                          if (_formKey.currentState!.validate() && selectedDate != null) {
                            saveReminder();
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Test Notifications Section
                    Text(
                      'Test Notifications:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _testNotification,
                        icon: const Icon(Icons.notifications, size: 20),
                        label: const Text('Send Test Notification'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
