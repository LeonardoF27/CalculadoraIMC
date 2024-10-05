import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

//A classe home vai gerenciar o estado da nossa aplicação:
//A tela em execução e os valores dos campos
class Home extends StatefulWidget {
//Utilizamos o override para
//sobrescrever o comportamento de criação da nossa aplicação
  @override
  _HomeState createState() => _HomeState();
}

//Esta classe representa a nossa view
//ela extende o Estado da aplicação que criamos anteriormente
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _resultado = "****";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _resultado = "****";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImcIdeal() {
    setState(() {
      double vlrPeso = double.parse(pesoController.text.replaceAll(',', '.'));
      double vlrAltura =
          double.parse(alturaController.text.replaceAll(',', '.'));

      double proporcao = vlrPeso / (vlrAltura * vlrAltura);
      _resultado = proporcao.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: pesoController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Peso(Kg)";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              TextFormField(
                controller: alturaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Altura(m)";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Altura(m)",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text("Calcule IMC",
                            style:
                                TextStyle(color: Colors.white, fontSize: 26.0)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[900]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcularImcIdeal();
                          }
                        },
                      ))),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0))
            ],
          ),
        ),
      ),
    );
  }
}
