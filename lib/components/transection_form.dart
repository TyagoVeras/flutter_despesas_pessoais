import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TransectionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransectionForm(this.onSubmit);

  @override
  _TransectionFormState createState() => _TransectionFormState();
}

class _TransectionFormState extends State<TransectionForm> {
  final valor = TextEditingController();
  final title = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final newTitle = title.text;
    final newValue = double.tryParse(valor.text) ?? 0.0;

    if (newTitle.isEmpty || newValue < 0 || _selectedDate == null) return;
    widget.onSubmit(newTitle, newValue, _selectedDate);
    Navigator.of(context).pop();
  }

  _showDatePicker() async {
    DateTime data = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());

    if (data == null) {
      return;
    }
    setState(() {
      _selectedDate = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova conta'),
      ),
      body: Container(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                ),
              ),
              TextField(
                controller: valor,
                onSubmitted: (_) => _submitForm(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text('Selecionar data'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Nova transação'),
                      style: ButtonStyle(
                          // backgroundColor:
                          //     MaterialStateProperty.all<Color>(
                          //         Colors.purple),
                          // foregroundColor:
                          //MaterialStateProperty.all<Color>(Colors.purple),
                          // elevation: MaterialStateProperty.all(10)
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
