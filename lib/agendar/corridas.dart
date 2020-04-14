import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Corridas extends StatelessWidget {
  Future<List> _pegarDados() async {
    //Mude essa URL para pegar os dados
    final response =
        await http.get('https://uber-clone.conveyor.cloud/api/uber');
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corridas'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: FutureBuilder<List>(
            future: _pegarDados(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final items = snapshot.data;
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        width: 350,
                        child: ListView.builder(
                          itemCount: items.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Card(
                              child: ListTile(
                                isThreeLine: true,
                                title: AutoSizeText(
                                  items[index]["local_destino"],
                                  minFontSize: 18,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Column(children: <Widget>[
                                  Text(items[index]["data"]),
                                  Text(items[index]["hora"]),
                                ]),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      'Origem: ${items[index]["local_origem"]}',
                                      minFontSize: 16,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    AutoSizeText(
                                      'Cliente: ${items[index]["nome_cliente"]}',
                                      minFontSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 150,
                    width: 150,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
