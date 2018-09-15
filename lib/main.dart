import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = 'Informe seus dados!';

  void _resetFields() {
    pesoController.text = '';
    alturaController.text = '';
    setState(() {
      _info = 'Informe seus dados!';
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoController.text.replaceAll(',', '.'));
      double altura = double.parse(
              alturaController.text.replaceAll('.', '').replaceAll(',', '')) /
          100;
      double imc = peso / (altura * altura);

      if (imc < 16.0) {
        _info = "Magreza Grave IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 16.0 && imc < 17.0) {
        _info = "Magreza Moderada IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 17.0 && imc < 18.5) {
        _info = "Magreza Leve IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 25.0) {
        _info = "Saudável IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc < 30.0) {
        _info = "Sobrepeso IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc < 35.0) {
        _info = "Obesidade IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35.0 && imc < 40.0) {
        _info = "Obesidade Severa IMC: (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40.0) {
        _info = "Obesidade Mórbida IMC: (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            //Para quando abrir o teclado permita rolar a página sem dar conflito
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.perm_identity,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Peso (kg)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                    controller: pesoController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira seu Peso!';
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                        labelText: 'Altura (cm)',
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                    controller: alturaController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira sua Altura!';
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          splashColor: Colors.deepOrange,
                          shape: const StadiumBorder(),
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.accessibility,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Calcular',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              ]),
                          color: Colors.green,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                        )),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 20.0),
                  )
                ],
              ),
            )));
  }
}
