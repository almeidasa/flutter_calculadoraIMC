import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculadora de IMC',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Índice de massa corporal (IMC)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _imc = 00.000;
  String _StrIMC = "";
  String _alt = "0.0";
  String _peso = "0.0";
  String _result = "";

  void _calculaIMC() {
    setState(() {
      if (_peso == "" || _alt == "") {
        _StrIMC = "";
        _result = "";
      } else {
        _imc = (double.parse(_peso) /
            (double.parse(_alt) * double.parse(_alt)).ceilToDouble());
        _StrIMC = "IMC: " + _imc.toString().substring(0, 6) + " kg/m²";

        if (_imc < 16.0) {
          _result = "Magreza Grave";
        } else if (_imc >= 16.0 && _imc < 17.0) {
          _result = "Magreza Moderada";
        } else if (_imc >= 17.0 && _imc < 18.5) {
          _result = "Magreza Leve";
        } else if (_imc >= 18.5 && _imc < 25.0) {
          _result = "Saudável";
        } else if (_imc >= 25.0 && _imc < 30.0) {
          _result = "Sobrepeso ";
        } else if (_imc >= 30.0 && _imc < 35.0) {
          _result = "Obesidade";
        } else if (_imc >= 35.0 && _imc < 40.0) {
          _result = "Obesidade Severa";
        } else if (_imc >= 40.0) {
          _result = "Obesidade Mórbida";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new TextField(
              onChanged: (text) {
                _alt = "$text".replaceAll(',', '.');
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Insira sua altura'),
            ),
            new TextField(
              onChanged: (text) {
                _peso = "$text".replaceAll(',', '.');
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Insira seu peso',
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Text('$_StrIMC',
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ))),
            Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  '$_result',
                  style: Theme.of(context).textTheme.display2,
                )),
            new RaisedButton(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.accessibility,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'CALCULAR IMC',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              onPressed: () {
                _calculaIMC();
              },
              color: Colors.green,
              splashColor: Colors.deepOrange,
              shape: const StadiumBorder(),
            )
          ],
        ),
      ),
    );
  }
}
