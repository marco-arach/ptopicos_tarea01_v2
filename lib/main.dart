import 'package:flutter/material.dart';
import 'package:google_cloud_translation/google_cloud_translation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Translation _translation;
  TextEditingController _textEditingController = TextEditingController();
  String _translatedText = '';
  String _detectedLanguage = '';
  String _selectedLanguage = 'en';

  @override
  void initState() {
    _translation = Translation(
      apiKey: 'AIzaSyBicvXQazxTfWQvlsHG_DQduaNIXWRmcz0',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PTopicos-Tarea 01'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Ingresa el texto a traducir',
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Traducir a: '),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('Inglés'),
                      ),
                      DropdownMenuItem(
                        value: 'es',
                        child: Text('Español'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String textToTranslate = _textEditingController.text;
                  TranslationModel translatedModel = await _translation.translate(text: textToTranslate, to: _selectedLanguage);
                  TranslationModel detectedModel = await _translation.detectLang(text: textToTranslate);

                  setState(() {
                    _translatedText = translatedModel.translatedText;
                    _detectedLanguage = detectedModel.detectedSourceLanguage;
                  });
                },
                child: Text('Traducir'),
              ),
              SizedBox(height: 30),
              Text('Traducción:', style: Theme.of(context).textTheme.headline6),
              Text(_translatedText, style: TextStyle(color: Colors.blueAccent)),
              Text('Idioma detectado - $_detectedLanguage', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
