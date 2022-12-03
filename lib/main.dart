import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      title: "App Clima",
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var descricao;
  var agora;
  var umidade;
  var velocidadedovento;
  String? apiKey = 'b2aac28faf159bdb767a6f2207460af7';
  String? openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
  String? cityName = "Marília";

  Future getDados() async {
    var url =
        Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);
    var resultado = jsonDecode(response.body);

    setState(() {
      temp = resultado['main']['temp'];
      descricao = resultado['weather'][0]['description'];
      agora = resultado['weather'][0]['main'];
      umidade = resultado['main']['humidity'];
      velocidadedovento = resultado['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Em Marília",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  temp != null ? "$temp\u00b0" : "Loading",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    descricao != null ? descricao.toString() : "Loading",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.temperatureHalf),
                  title: const Text('Temperatura'),
                  trailing: Text(temp != null ? "$temp\u00b0" : "Loading"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.cloud),
                  title: const Text('Clima'),
                  trailing: Text(
                    descricao != null ? descricao.toString() : "Loading",
                  ),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.sun),
                  title: const Text('Umidade'),
                  trailing:
                      Text(umidade != null ? umidade.toString() : "Loading"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.wind),
                  title: const Text('Velocidade do vento'),
                  trailing: Text(velocidadedovento != null
                      ? velocidadedovento.toString()
                      : "Loading"),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
