import 'package:expenses/models/transection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Transectionlist extends StatefulWidget {
  final List<Transection> transections;
  final void Function(String) onRemove;
  Transectionlist(this.transections, this.onRemove);

  @override
  _TransectionlistState createState() => _TransectionlistState();
}

class _TransectionlistState extends State<Transectionlist> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
    return Container(
      height: MediaQuery.of(context).size.width,
      child: widget.transections.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Nenhuma transação cadastrada',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/img/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              reverse: false,
              itemCount: widget.transections.length,
              itemBuilder: (_, index) {
                final e = widget.transections[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(child: Text('R\$${e.value}')),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => widget.onRemove(e.id),
                        color: Theme.of(context).errorColor,
                      ),
                      title: Text(
                        e.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text('${e.date}'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
