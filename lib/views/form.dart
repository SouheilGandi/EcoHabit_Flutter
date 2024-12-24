import 'package:email_validator/email_validator.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:timesheet/services/auth_service.dart';
import 'package:timesheet/services/mailer_2.dart';
import 'package:timesheet/views/signature.dart';
import 'package:timesheet/widgets/email_widget.dart';
import '../viewmodels/form_viewmodel.dart';
import '../services/generate_pdf.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final SignatureController _signatureControllerClient = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  final SignatureController _signatureControllerEngineer = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  final TextEditingController _emailController = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");
  final _formKey=GlobalKey<FormState>();

  @override
  void dispose(){
    _signatureControllerClient.dispose();
    _signatureControllerEngineer.dispose();
    _emailController.dispose();
    super.dispose();
  }

    void _openSignatureView(SignatureController controller, String title, Function(String) onSave) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignatureView(
          controller: controller,
          title: title,
          onSave: onSave,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formViewModel = Provider.of<FormViewModel>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiche d\'Intervention',
        style: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0)
        ),),
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(80),
            bottomLeft: Radius.circular(80),
          )
        ),
        backgroundColor:const Color.fromARGB(255, 249, 246, 246),
              actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            // Appel de la méthode de déconnexion
            await AuthService().logout();
            // Naviguer vers la page de connexion
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child:Form(
         key: _formKey,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text('Date d\'intervention',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
            ),
            ),
            const SizedBox(height: 4,),
            _buildDateField(formViewModel,Icons.date_range_rounded),
            const SizedBox(height: 16.0),
            _buildTimeField('Heure d\'Arrivée', formViewModel, 'arrivalTime',Icons.hourglass_top_outlined),
            const SizedBox(height: 16.0),
            _buildTimeField('Heure de Départ', formViewModel, 'departureTime',Icons.hourglass_bottom_outlined),
            const SizedBox(height: 16.0),
            const Text('Informations client',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
            ),
            ),
            const SizedBox(height: 4,),
            _buildTextField('Raison Sociale', formViewModel, 'raisonSociale',TextInputType.name,Icons.work_rounded),
            const SizedBox(height: 16.0),
            _buildTextField('Responsable', formViewModel, 'responsable',TextInputType.name,Icons.man_2_rounded),
            const SizedBox(height: 16.0),
            EmailFieldWidget(controller: _emailController,  onChanged: (value) {
             formViewModel.updateField('emailResponsable', value);},),
            const SizedBox(height: 16.0),
            _buildPhoneField(formViewModel),
            const SizedBox(height: 16.0),
            const Center(child:Text('----------')),
            _buildTextField('Description de l\'Intervention', formViewModel, 'descriptionIntervention',TextInputType.multiline,Icons.description_rounded),
            const SizedBox(height: 16.0),
            _buildTextField('Travaux Effectués', formViewModel, 'travauxEffectues',TextInputType.multiline,Icons.design_services_rounded),
            const SizedBox(height:16.0),
            const Center(child:Text('----------')),
            const SizedBox(height: 16.0),
              Row(
               children:[
               const Icon(CupertinoIcons.doc_richtext),
               const Text('Type de fiches',
               style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
               ),),
               const SizedBox(width: 20,),
              _buildDropdownField(formViewModel),
              ],
              ),
            const SizedBox(height:16.0),
            const Center(child:Text('----------')),
            const SizedBox(height: 16.0),
            _buildCheckboxList(formViewModel),
            const SizedBox(height: 16.0),
            const Text('Evaluation de l\'intervention',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
            ),
            ),
            const SizedBox(height: 4,),
            _buildRadioList(formViewModel),
            const SizedBox(height: 16.0),
            _buildTextField('Commentaire du Client', formViewModel, 'commentaireClient',TextInputType.multiline,Icons.comment_rounded),
            const SizedBox(height: 16.0),
            _buildSwitchListTile(formViewModel),
            const SizedBox(height: 16.0),
            _buildTextField('Nom de l\'ingénieur', formViewModel, 'ingenieurNom',TextInputType.name,Icons.how_to_reg_rounded),
            const SizedBox(height: 8,),
             Row(children: [
              const Icon(CupertinoIcons.pencil_circle_fill),
              const SizedBox(width: 12,),
              Text(
                'Signature de l\'ingénieur',
                style: GoogleFonts.lato(
                textStyle:const TextStyle(
                  fontSize: 18.5,
                  color: Color.fromARGB(255, 0, 0, 0),
                  //decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  decorationColor: Colors.red
                ),
                ),
              )
            ],),
            const SizedBox(height: 12,),

                          ElevatedButton(
                onPressed: () {
                  _openSignatureView(
                    _signatureControllerEngineer,
                    'Signature de l\'ingénieur',
                    (signature) => formViewModel.updateField('ingenieurSignature', signature),
                  );
                },
                child: const Text('Ajouter la signature de l\'ingénieur'),
              ),
            const SizedBox(height: 30.0),
            _buildTextField('Nom de Client', formViewModel, 'clientNom',TextInputType.name,Icons.face_rounded),
            Row(children: [
              const Icon(CupertinoIcons.pencil_circle_fill),
              const SizedBox(width: 12,),
              Text(
                'Signature Client',
                style: GoogleFonts.lato(
                textStyle:const TextStyle(
                  fontSize: 18.5,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  //decoration: TextDecoration.underline,
                  decorationColor: Colors.red
                ),
                ),
              )
            ],),
            const SizedBox(height: 12,),

                          ElevatedButton(
                onPressed: () {
                  _openSignatureView(
                    _signatureControllerClient,
                    'Signature Client',
                    (signature) => formViewModel.updateField('clientSignature', signature),
                  );
                },
                child: const Text('Ajouter la signature du client'),
              ),
                Text(
                'J\'ai lu et j\'approuve .',
                style: GoogleFonts.lato(
                textStyle:const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 163, 4, 4),
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromARGB(255, 163, 4, 4)
                ),
                ),
              ),
            const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    if (!EmailValidator.validate(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Entrez un email valide !')),
                      );
                      return;
                    }
                    print('Email from Controller: $email');
                        formViewModel.updateField('emailResponsable', email);
                        print('Email Responsable in ViewModel after update: ${formViewModel.formData.emailResponsable}');
                    if (!_formKey.currentState!.validate()) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Veuillez corriger les erreurs dans le formulaire')),
                      );
                      return;
                    }

                    // Get the signatures from the formViewModel
                    final engineerSignature = formViewModel.getField('ingenieurSignature');
                    final clientSignature = formViewModel.getField('clientSignature');

                    if (engineerSignature != null && clientSignature != null) {
                       print('Email Responsable: ${_emailController.text}');

                      formViewModel.submitForm();
                      try {
                        final pdfFile = await generatePdf(formViewModel);
                        await sendEmail2(context,pdfFile, email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form submitted and email sent!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Veuillez insérer les signatures')),
                      );
                    }
                  },
                style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      ),
                child: const Text('Valider'),
              ),
              
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildPhoneField(FormViewModel formViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: PhoneNumberInput(
        hint: 'Numéro de responsable',
        initialCountry: 'TN', // Set this to your default country code
        locale: 'fr', // Set this to your desired locale
        countryListMode: CountryListMode.dialog, // or CountryListMode.bottomSheet
        contactsPickerPosition: ContactsPickerPosition.suffix, // Change as needed
        onChanged: (phoneNumber) {
          formViewModel.updateField('telephoneResponsable', phoneNumber);
        },
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color.fromARGB(255, 253, 15, 15)),
        ),
      ),
    );
  }


  Widget _buildTextField(String label, FormViewModel formViewModel, String fieldName,TextInputType input,[IconData? prefixIcon]) {
   // final textController=TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
       // controller: textController,
        keyboardType:input ,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
            ),
          focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: const BorderSide(color: Color.fromARGB(255, 253, 15, 15)),
        ),
        ),
        onChanged: (value) {
          formViewModel.updateField(fieldName, value);
        },
        validator: (value){
          if( value ==null || value.isEmpty ){
            return '$fieldName ne peut pas être vide';
          }
          return null;
        },

      ),
    );
  }



  Widget _buildDateField(FormViewModel formViewModel,[IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DateTimeField(
        format: format,
        validator: (value){
          if (value ==null ){
            return 'Veuillez choisir une date !';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: 'Date d\'Intervention',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon:icon !=null ? Icon(icon) : null,
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (date != null) {
            formViewModel.updateField('dateIntervention', date);
          }
          return date;
        },
      ),
    );
  }

Widget _buildTimeField(String label, FormViewModel formViewModel, String fieldName, [IconData? icon]) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: DateTimeField(
      format: timeFormat,
      validator: (value) {
        if (value == null) {
          return 'Veuillez choisir $label !';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      initialValue: _convertToDateTime(formViewModel.getField(fieldName)),
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: _convertToTimeOfDay(currentValue) ?? TimeOfDay.now(),
        );
        if (time != null) {
          formViewModel.updateField(fieldName, time);  // Update as TimeOfDay
        }
        return time != null ? _convertToDateTime(time) : null;
      },
    ),
  );
}

DateTime? _convertToDateTime(TimeOfDay? timeOfDay) {
  if (timeOfDay == null) return null;
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
}

TimeOfDay? _convertToTimeOfDay(DateTime? dateTime) {
  if (dateTime == null) return null;
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}


  Widget _buildDropdownField(FormViewModel formViewModel) {
    return Center(
     // padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButton<String>(
        value: formViewModel.formData.typeIntervention.isNotEmpty ? formViewModel.formData.typeIntervention : null,
        hint: const Text(
          'Type d\'intervention',
        style: TextStyle(
          color: Color.fromARGB(170, 0, 0, 0),
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 18,
          
        ),
        ),
        onChanged: (value) {
          formViewModel.updateField('typeIntervention', value);
        },
        items: <String>['Intervention', 'Incident', 'Projet'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                    style: const TextStyle(
                    color: Color.fromARGB(170, 0, 0, 0),
                    //fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,  
              ),
            ),
          );
        }).toList(),

      ),
    );
  }

  Widget _buildCheckboxList(FormViewModel formViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Nature de l\'Intervention',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          ),
          ...['Intervention client sous contrat', 'Intervention payante', 'Visite périodique', 'Audit', 'Nombre de 1/2 journées'].map((String value) {
            return CheckboxListTile(
              title: Text(value),
              value: formViewModel.formData.natureIntervention.contains(value),
              onChanged: (bool? checked) {
                final nature = List<String>.from(formViewModel.formData.natureIntervention);
                if (checked == true) {
                  nature.add(value);
                } else {
                  nature.remove(value);
                }
                formViewModel.updateField('natureIntervention', nature);
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRadioList(FormViewModel formViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Appréciation Globale',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),),
          ...['Mauvais', 'Moyen', 'Bon', 'Très bon', 'Excellent'].map((String value) {
            return RadioListTile<String>(
              title: Text(value),
              value: value,
              groupValue: formViewModel.formData.appreciationGlobale,
              onChanged: (value) {
                formViewModel.updateField('appreciationGlobale', value);
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(FormViewModel formViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SwitchListTile(
        title: const Text('Intervention Terminée ?',
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
        ),),
        value: formViewModel.formData.interventionTerminee,
        onChanged: (value) {
          formViewModel.updateField('interventionTerminee', value);
        },
      ),
    );
  }
}
