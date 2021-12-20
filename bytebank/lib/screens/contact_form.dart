import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final ContactDao _contactDao = ContactDao();

  final String _appBarTitle = 'Adicionar contato';
  final String _nameInputLabel = 'Nome completo';
  final String _accountNumberInputLabel = 'Número da conta';
  final String _confirmButtonText = 'Confirmar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: _nameInputLabel,
            ),
            style: TextStyle(fontSize: 16.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _accountNumber,
              decoration: InputDecoration(
                labelText: _accountNumberInputLabel,
              ),
              style: TextStyle(
                fontSize: 16.0,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
            ),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  final String? name = _nameController.text;
                  final int? accountNumber = int.tryParse(_accountNumber.text);
                  if (name != null && accountNumber != null) {
                    final Contact newContact = Contact(0, name, accountNumber);
                    _contactDao
                        .save(newContact)
                        .then((id) => Navigator.pop(context));
                  }
                },
                child: Text(_confirmButtonText),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
