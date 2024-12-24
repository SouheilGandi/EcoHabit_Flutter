import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'dart:convert';

class SignatureView extends StatefulWidget {
  final SignatureController controller;
  final String title;
  final Function(String) onSave;

  const SignatureView({
    Key? key,
    required this.controller,
    required this.title,
    required this.onSave,
  }) : super(key: key);

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: widget.controller,
              backgroundColor: Colors.grey[200]!,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.controller.clear();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Effacer la signature'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final signatureBytes = await widget.controller.toPngBytes();
                  if (signatureBytes != null) {
                    final signatureBase64 = base64Encode(signatureBytes);
                    widget.onSave(signatureBase64);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: const Text('Sauvegarder'),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
