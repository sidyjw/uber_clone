import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Agendar extends StatefulWidget {
  @override
  _AgendarState createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Corrida'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(child: FormAgendar()),
        ),
      ),
    );
  }
}

class FormAgendar extends StatefulWidget {
  @override
  FormAgendarState createState() {
    return FormAgendarState();
  }
}

class FormAgendarState extends State<FormAgendar> {
  final _formKey = GlobalKey<FormState>();
  final _inputNome = TextEditingController();
  final _inputOrigem = TextEditingController();
  final _inputDestino = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _inputNome,
            decoration: const InputDecoration(labelText: 'Seu Nome'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Escreva seu nome';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
          TextFormField(
            controller: _inputOrigem,
            decoration: const InputDecoration(labelText: 'Seu Endereço Atual'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Insira seu endereço';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
          TextFormField(
            controller: _inputDestino,
            decoration: const InputDecoration(labelText: 'Seu Destino'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Insira seu destino';
              }
              return null;
            },
          ),
          SizedBox(height: 25.0),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                final dataHora = DateTime.now();
                //Mude essa URL para enviar os dados
                await http.post('https://uber-clone.conveyor.cloud/api/uber',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(
                      <String, String>{
                        'nome_cliente': _inputNome.text,
                        'local_origem': _inputOrigem.text,
                        'local_destino': _inputDestino.text,
                        'data':
                            "${dataHora.day}/${dataHora.month}/${dataHora.year}",
                        'hora': "${dataHora.hour}:${dataHora.minute}",
                      },
                    ));
                Navigator.pop(context);
              }
            },
            padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
            color: Colors.black,
            child: Text(
              'Enviar',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
