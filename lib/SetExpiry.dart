import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackncheck/components/Button.dart';
import 'package:trackncheck/components/InputFields.dart';
import 'package:trackncheck/components/TextWidgets.dart';
import 'package:trackncheck/components/constants.dart';
import 'package:trackncheck/controller/ExpiryController.dart';

class Setexpiry extends StatefulWidget {
  const Setexpiry({super.key});

  @override
  State<Setexpiry> createState() => _SetexpiryState();
}

class _SetexpiryState extends State<Setexpiry> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  DateTime? selectedDate;

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
      await Expirycontroller.saveExpiryReminder(
        productName: _productNameController.text,
        expiryDate: selectedDate!,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reminder saved')),
      );

      _productNameController.clear();
      _expiryDateController.clear();
      selectedDate = null;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save: $e')));
    }
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
                      offset: Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form Title
                    const SizedBox(height: 20),

                    // Product Name Field
                    Inputfields(
                      controller: _productNameController,
                      emptyFields: "Please enter product name",
                      icon: Icons.production_quantity_limits_sharp,
                      hintText: 'Product name',
                    ),
                    const SizedBox(height: 16),

                    // Expiry Date Field (Date Picker)
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

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        text: "Save Reminder",
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              selectedDate != null) {
                            saveReminder();
                          }
                        },
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
