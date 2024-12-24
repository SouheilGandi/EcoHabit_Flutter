import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:timesheet/viewmodels/form_viewmodel.dart';
import 'package:path_provider/path_provider.dart';

Future<File> generatePdf(FormViewModel formViewModel) async {
  final pdf = pw.Document();

  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Fiche d\'Intervention', style: pw.TextStyle(fontSize: 24,fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 24),
            pw.Text('Date d\'intervention: ${formViewModel.formData.dateIntervention.toString()}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Heure d\'Arrivée: ${formatTimeOfDay(formViewModel.formData.arrivalTime)}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Heure de Départ: ${formatTimeOfDay(formViewModel.formData.departureTime)}', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:16),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height: 16),
            pw.Text('Raison Sociale: ${formViewModel.formData.raisonSociale}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Responsable: ${formViewModel.formData.responsable}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Email: ${formViewModel.formData.emailResponsable}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Téléphone: ${formViewModel.formData.telephoneResponsable}', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:16),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height:16),
            pw.Text('Description de l\'Intervention: ${formViewModel.formData.descriptionIntervention}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Travaux Effectués: ${formViewModel.formData.travauxEffectues}', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:16),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height:16),
            pw.Text('Type d\'intervention: ${formViewModel.formData.typeIntervention}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Nature de l\'Intervention: ${formViewModel.formData.natureIntervention.join(", ")}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('interventionTerminee: ${formViewModel.formData.interventionTerminee ? "Oui" : "Non"}', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:16),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height:16),
            pw.Text('Appréciation Globale: ${formViewModel.formData.appreciationGlobale}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Commentaire du Client: ${formViewModel.formData.commentaireClient}', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:16),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height:16),
            pw.Text('Nom de l\'Ingénieur: ${formViewModel.formData.ingenieurNom}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Signature de l\'ingénieur :', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:10),
            pw.Container(
              width: 150,
              height: 50,
              child: pw.Image(
                pw.MemoryImage(base64Decode(formViewModel.formData.ingenieurSignature)),
                fit: pw.BoxFit.contain,
              ),
            ),
            pw.SizedBox(height:10),
            pw.Divider(color: PdfColors.grey, thickness: 1),
            pw.SizedBox(height:10),
            pw.Text('Nom du Client: ${formViewModel.formData.clientNom}', style: const pw.TextStyle(fontSize: 11)),
            pw.Text('Signature du client :', style: const pw.TextStyle(fontSize: 11)),
            pw.SizedBox(height:10),

            pw.Container(
              width: 150,
              height: 50,
              child: pw.Image(
                pw.MemoryImage(base64Decode(formViewModel.formData.clientSignature)),
                fit: pw.BoxFit.contain,
              ),
            ),
          ],
        )
        );
      },
    ),
  );
  
  final directory = await getApplicationDocumentsDirectory();
  final outputFile=File('${directory.path}/fiche_intervention.pdf');

  await outputFile.writeAsBytes(await pdf.save());
  return outputFile;
}