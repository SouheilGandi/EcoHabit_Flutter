import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:timesheet/models/form.dart';
import 'package:timesheet/services/form_service.dart';
import 'package:signature/signature.dart';


class FormViewModel extends ChangeNotifier{
  final FormService _formService = FormService(); 
  Uint8List? signature;
  late Map<String,dynamic> payload;
  final FormModel _formData = FormModel(
   dateIntervention: DateTime.now(),
    arrivalTime: TimeOfDay.now(),
    departureTime: TimeOfDay.now(),
    raisonSociale: '',
    responsable: '',
    emailResponsable: '',
    telephoneResponsable: '',
    descriptionIntervention: '',
    travauxEffectues: '',
    natureIntervention: [],
    appreciationGlobale: '',
    commentaireClient: '',
    interventionTerminee: false,
    ingenieurNom: '',
    ingenieurSignature: '',
    clientNom: '',
    clientSignature: '',
    typeIntervention: '', 
  );

FormModel get formData => _formData;

  void updateField(String fieldName, dynamic value) {
    switch (fieldName) {
      case 'dateIntervention':
        _formData.dateIntervention = value;
        break;
      case 'arrivalTime':
        _formData.arrivalTime = value;
        break;
      case 'departureTime':
        _formData.departureTime = value;
        break;
      case 'raisonSociale':
        _formData.raisonSociale = value;
        break;
      case 'responsable':
        _formData.responsable = value;
        break;
      case 'emailResponsable':
        _formData.emailResponsable = value;
        break;
      case 'telephoneResponsable':
        _formData.telephoneResponsable = value;
        break;
      case 'descriptionIntervention':
        _formData.descriptionIntervention = value;
        break;
      case 'travauxEffectues':
        _formData.travauxEffectues = value;
        break;
      case 'natureIntervention':
        _formData.natureIntervention = value;
        break;
      case 'appreciationGlobale':
        _formData.appreciationGlobale = value;
        break;
      case 'commentaireClient':
        _formData.commentaireClient = value;
        break;
      case 'interventionTerminee':
        _formData.interventionTerminee = value;
        break;
      case 'ingenieurNom':
        _formData.ingenieurNom = value;
        break;
      case 'ingenieurSignature':
        _formData.ingenieurSignature = value;
        break;
      case 'clientNom':
        _formData.clientNom = value;
        break;
      case 'clientSignature':
        _formData.clientSignature = value;
        break;
      case 'typeIntervention':
        _formData.typeIntervention = value;
        break;
    }
    payload = _formData.toJson();
    notifyListeners();
  }
Future<void> submitForm() async {
    final formData = {
      'dateIntervention': _formData.dateIntervention.toIso8601String(),
      'arrivalTime': '${_formData.arrivalTime.hour}:${_formData.arrivalTime.minute}',
      'departureTime': '${_formData.departureTime.hour}:${_formData.departureTime.minute}',
      'raisonSociale': _formData.raisonSociale,
      'responsable': _formData.responsable,
      'emailResponsable': _formData.emailResponsable,
      'telephoneResponsable': _formData.telephoneResponsable,
      'descriptionIntervention': _formData.descriptionIntervention,
      'travauxEffectues': _formData.travauxEffectues,
      'natureIntervention': _formData.natureIntervention,
      'appreciationGlobale': _formData.appreciationGlobale,
      'commentaireClient': _formData.commentaireClient,
      'interventionTerminee': _formData.interventionTerminee,
      'ingenieurNom': _formData.ingenieurNom,
      'ingenieurSignature': _formData.ingenieurSignature,
      'clientNom': _formData.clientNom,
      'clientSignature': _formData.clientSignature,
      'typeIntervention': _formData.typeIntervention,
    };
    //print('FormViewModel Payload: $formData');
    final success = await _formService.submitForm(formData);

    if (success) {
      // Handle successful form submission
      print('Form submitted successfully');
    } else {
      // Handle failure
      print('Failed to submit form');
    }
  }

  void clearSignature(SignatureController signatureController){
    signature = null;
    notifyListeners();
    signatureController.clear();
  }
  dynamic getField(String fieldName) {
    switch (fieldName) {
      case 'dateIntervention':
        return _formData.dateIntervention;
      case 'arrivalTime':
        return _formData.arrivalTime;
      case 'departureTime':
        return _formData.departureTime;
      case 'raisonSociale':
        return _formData.raisonSociale;
      case 'responsable':
        return _formData.responsable;
      case 'emailResponsable':
        return _formData.emailResponsable;
      case 'telephoneResponsable':
        return _formData.telephoneResponsable;
      case 'descriptionIntervention':
        return _formData.descriptionIntervention;
      case 'travauxEffectues':
        return _formData.travauxEffectues;
      case 'natureIntervention':
        return _formData.natureIntervention;
      case 'appreciationGlobale':
        return _formData.appreciationGlobale;
      case 'commentaireClient':
        return _formData.commentaireClient;
      case 'interventionTerminee':
        return _formData.interventionTerminee;
      case 'ingenieurNom':
        return _formData.ingenieurNom;
      case 'ingenieurSignature':
        return _formData.ingenieurSignature;
      case 'clientNom':
        return _formData.clientNom;
      case 'clientSignature':
        return _formData.clientSignature;
      case 'typeIntervention':
        return _formData.typeIntervention;
      default:
        return null;
    }
  }



}