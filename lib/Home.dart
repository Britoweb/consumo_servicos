import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "";

  TextEditingController _textEditingController = TextEditingController();

  _recuperarCep() async{

    String cepDigitado = _textEditingController.text;
    String url = "https://viacep.com.br/ws/${cepDigitado }/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = jsonDecode(response.body);

    String cep = retorno["cep"];
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      _resultado = "Cep: ${cep}, Logradouro: ${logradouro}, Complemento: ${complemento}, Bairro: ${bairro}, Localidade: ${localidade}, UF: ${uf}";
    });


    // print("Resposta: CEP: ${cep}, Logradouro: ${logradouro}, Complemento: ${complemento}, Bairro: ${bairro}, Localidade: ${localidade}, UF: ${uf}," );


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web!"),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Digite um CEP"
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
                onSubmitted: (String texto){
                  print("valor digitado:" +  texto);
                },
                controller: _textEditingController,

              ),
            ),
            ElevatedButton(
                onPressed: ()  {
                  _recuperarCep();
                },
                child: Text(
                  "Buscar"
                ),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
