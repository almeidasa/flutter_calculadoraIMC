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
      home: new MyHomePage(title: 'Calcular IMC'),
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
  String _alt = "0.0";
  String _peso = "0.0";
  String _result = "";
  void _calculaIMC() {
    setState(() {
        _imc = (double.parse(_peso) / (double.parse(_alt)*double.parse(_alt)).ceilToDouble());
        if(_imc < 18.5){
          _result = "Abaixo do peso";
        } else if(_imc >= 18.5 && _imc < 24.9){
          _result = "Peso normal";
        } else if(_imc >= 24.9 && _imc < 30.0){
          _result = "Sobrepeso";
        } else if (_imc >= 30.0){
          _result = "Obesidade";
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
              onChanged: (text){
                _alt = "$text".replaceAll(',', '.');
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
               labelText: 'Insira sua altura'
              ),
            ),
            new TextField(
              onChanged: (text){
                _peso = "$text";
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Insira seu peso',
              ),
            ),

            new Text(
              '$_imc',
              style: Theme.of(context).textTheme.display1,
            ),

            new Text(
              '$_result',
              style: Theme.of(context).textTheme.display2,
            ),
            new RaisedButton(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0
                  ),
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
                )
              ),
              onPressed: (){
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
