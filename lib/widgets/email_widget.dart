import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const EmailFieldWidget({super.key, required this.controller, required this.onChanged});

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState(){
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose(){
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() =>setState(() {});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: 'Email de responsable',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
         focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color.fromARGB(255, 253, 15, 15)),
          ),
        prefixIcon: const Icon(Icons.mail),
        suffixIcon: widget.controller.text.isEmpty
            ? Container(width: 0,)
            : IconButton(onPressed: () => widget.controller.clear(), icon: const Icon(Icons.close)),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      validator: (email) => (email != null && !EmailValidator.validate(email))
          ?'Enter a valid email'
          :null,
    );
  }
}