import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> sendEmail(BuildContext context,File pdfFile,String recipientEmail) async {
  final Email email=Email(
    body:'Please find attached the PDF document. ',
    subject:'Fiche d\'Intervention',
    recipients:[recipientEmail],
    attachmentPaths:[pdfFile.path],
    isHTML:false,
  );
try {
    await FlutterEmailSender.send(email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email sent successfully!')),
    );
  } catch (e) {
  print('Error sending email: $e');
  if (e is PlatformException) {
    print('Platform Exception Code: ${e.code}');
    print('Platform Exception Message: ${e.message}');
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error sending email: $e')),
  );
}
}