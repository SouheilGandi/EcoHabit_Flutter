import 'package:flutter/material.dart';

class FormModel{
  DateTime dateIntervention;
  TimeOfDay arrivalTime;
  TimeOfDay departureTime;
  String raisonSociale;
  String responsable;
  String emailResponsable;
  String telephoneResponsable;
  String descriptionIntervention;
  String travauxEffectues;
  List<String> natureIntervention;
  String appreciationGlobale;
  String commentaireClient;
  bool interventionTerminee;
  String ingenieurNom;
  String ingenieurSignature;
  String clientNom;
  String clientSignature;
  String typeIntervention;
  
  FormModel({
    required this.dateIntervention,
    required this.arrivalTime,
    required this.departureTime,
    required this.raisonSociale,
    required this.responsable,
    required this.emailResponsable,
    required this.telephoneResponsable,
    required this.descriptionIntervention,
    required this.travauxEffectues,
    required this.natureIntervention,
    required this.appreciationGlobale,
    required this.commentaireClient,
    required this.interventionTerminee,
    required this.ingenieurNom,
    required this.ingenieurSignature,
    required this.clientNom,
    required this.clientSignature,
    required this.typeIntervention, 
  });
  Map<String, dynamic> toJson() {
    return {
      'dateIntervention': dateIntervention.toIso8601String(),
      'arrivalTime': '${arrivalTime.hour}:${arrivalTime.minute}',
      'departureTime': '${departureTime.hour}:${departureTime.minute}',
      'raisonSociale': raisonSociale,
      'responsable': responsable,
      'emailResponsable': emailResponsable,
      'telephoneResponsable': telephoneResponsable,
      'descriptionIntervention': descriptionIntervention,
      'travauxEffectues': travauxEffectues,
      'natureIntervention': natureIntervention,
      'appreciationGlobale': appreciationGlobale,
      'commentaireClient': commentaireClient,
      'interventionTerminee': interventionTerminee,
      'ingenieurNom': ingenieurNom,
      'ingenieurSignature': ingenieurSignature,
      'clientNom': clientNom,
      'clientSignature': clientSignature,
      'typeIntervention': typeIntervention,
    };
  }
}