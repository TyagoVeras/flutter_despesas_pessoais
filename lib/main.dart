import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transection_form.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'components/transection_form.dart';
import 'components/transection_list.dart';
import 'models/transection.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({Key key}) : super(key: key);

  @override
  _ExpensesAppState createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light()
            .textTheme
            .copyWith(headline6: TextStyle(fontSize: 20)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transection> get _recentTransactions {
    return _transections.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransection(String title, double value, DateTime date) {
    final newTransection = Transection(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transections.add(newTransection);
    });
  }

  _deleteTransection(String id) {
    setState(() {
      _transections.removeWhere((element) => element.id == id);
    });
  }

  final List<Transection> _transections = [
    // Transection(
    //   id: 't1',
    //   title: 'Novo Tênis de corrida',
    //   value: 310.76,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transection(
    //   id: 't2',
    //   title: 'Conta de luz',
    //   value: 211.30,
    //   date: DateTime.now().subtract(Duration(days: 4)),
    // )
  ];
  _openTransectionFormModal(BuildContext context) {
    showModalBottomSheet(
        //useSafeArea: false,
        context: context,
        builder: (_) {
          return TransectionForm(_addTransection);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _openTransectionFormModal(context)),
        ],
        title: Text('Despesas pessoais'),
      ),
      body: ListView(
        children: [
          Chart(_recentTransactions),
          Transectionlist(_transections, _deleteTransection),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransectionFormModal(context),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
