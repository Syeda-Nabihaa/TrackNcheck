import 'package:flutter/material.dart';
import 'package:trackncheck/controller/BoycottedProductController.dart';

class BoycottCheckerWidget extends StatefulWidget {
  final String scannedBrand;

  const BoycottCheckerWidget({Key? key, required this.scannedBrand})
    : super(key: key);

  @override
  _BoycottCheckerWidgetState createState() => _BoycottCheckerWidgetState();
}

class _BoycottCheckerWidgetState extends State<BoycottCheckerWidget> {
  Map<String, dynamic>? boycottInfo;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _checkBoycott();
  }

  Future<void> _checkBoycott() async {
    final info = await checkBoycottStatus(widget.scannedBrand);
    setState(() {
      boycottInfo = info;
      loading = false;
    });
    if (info != null) {
      _showBoycottDialog();
    }
  }

  void _showBoycottDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("⚠️ Boycotted Brand"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Brand: ${boycottInfo!['Brand']}")],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Colors.amber;
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (boycottInfo == null) {
      return Center(
        child: Text(
          "✅ Brand '${widget.scannedBrand}' is not boycotted.",
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    // If boycott info is present, dialog is already shown
    return const SizedBox.shrink(); // Empty widget
  }
}
