import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:timesheet/api/google_auth_api.dart';

Future<void> sendEmail2(BuildContext context, File pdfFile, String recipientEmail) async {
  final user= await GoogleAuthApi.signIn();

if (user == null) return;

  final email=user.email;
  final auth=await user.authentication;
  final token=auth.accessToken;

  GoogleAuthApi.signOut();

  final smtpServer = gmailSaslXoauth2(email, token!); // Use your email and app password here
  final message = Message()
    ..from = Address(email, 'Souheil')
    ..recipients.add(recipientEmail)
    ..subject = 'Fiche d\'Intervention'
    ..text = 'Please find attached the PDF document.'
    ..attachments.add(FileAttachment(pdfFile));

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email sent successfully!')),
    );
  } catch (e) {
    print('Message not sent. Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error sending email: $e')),
    );
  }
}
