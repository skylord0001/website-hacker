import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Website Content Hacker made with 💖 by Black Stack Hub';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black87,
          secondary: Colors.black,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.green,
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: const Color.fromARGB(255, 255, 0, 0),
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final form = TextEditingController();
  String content = "";
  String webnotfound = "";

  Future<void> submitForm(text) async {
    Uri url = Uri.parse(text);
    try {
      http.Response response = await http.get(url);
      String site = response.body;
      site = site.replaceAll("http", "hacked");
      site = site.replaceAll("link", "hacked");
      site = site.replaceAll("user-select:", "hacked");
      site = site.replaceAll("::selection", "hacked");
      site = site.replaceAll("::-moz-selection", "hacked");
      site = site.replaceAll("noscript", "style");
      site = site.replaceAll("script", "style");
      site = site.replaceAll("img src=\"hacked", "img src=\"http");
      site = site.replaceAll("iframe src=\"hacked", "iframe src=\"http");
      site = site.replaceAll("img alt src=\"hacked", "img alt src=\"http");
      setState(() {
        content = site;
        webnotfound = "Show Hacked Website";
      });
    } catch (e) {
      setState(() {
        webnotfound = e.toString();
      });
    }
  }

  String onInput(value) {
    setState(() {
      webnotfound = "";
      content = "";
    });
    return "";
  }

  Future<void> _launchUrl(hack) async {
    if (!await launchUrl(hack)) {
      throw 'Could not launch $hack';
    }
  }

  Future<void> browse(content) async {
    var permission = await Permission.manageExternalStorage.isGranted;
    if (permission) {
      Permission.manageExternalStorage.request();
    }
    String hack = "${Directory.current.path}\\hack.html";
    final Uri website = Uri.parse(hack);
    File file = File(hack);
    await file.writeAsString(content).then((value) {
      _launchUrl(website);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(50),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/matrix.jpg"),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                selectionControls: MaterialTextSelectionControls(),
                cursorColor: const Color.fromARGB(255, 255, 0, 0),
                controller: form,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                  backgroundColor: Colors.black,
                  fontSize: 20,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Website Url First';
                  }
                  return null;
                },
                onChanged: (value) {
                  onInput(value);
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF033F05), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF033F05), width: 2.0),
                  ),
                  hintText: ' https://example.com/path',
                  labelText: ' Enter the fVcking webSite Url',
                  hintStyle: TextStyle(color: Colors.yellow),
                  labelStyle: TextStyle(color: Colors.yellow),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(40),
              child: TextButton(
                style: ButtonStyle(
                  minimumSize: const MaterialStatePropertyAll(Size(200, 100)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF033F05)),
                  shadowColor:
                      MaterialStateProperty.all(const Color(0xFF033F05)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitForm(form.text);
                    setState(() {
                      webnotfound = "Loading...";
                    });
                  }
                },
                child: const Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 0, 0),
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            webnotfound != ""
                ? Padding(
                    padding: const EdgeInsets.all(100),
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize:
                            const MaterialStatePropertyAll(Size(500, 100)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                        backgroundColor: MaterialStateProperty.all(
                            webnotfound != "Show Hacked Website"
                                ? const Color.fromARGB(255, 255, 0, 0)
                                : const Color(0xFF033F05)),
                        shadowColor: MaterialStateProperty.all(
                            webnotfound != "Show Hacked Website"
                                ? const Color.fromARGB(255, 255, 0, 0)
                                : const Color(0xFF033F05)),
                      ),
                      onPressed: () {
                        webnotfound != "Show Hacked Website"
                            ? null
                            : browse(content);
                      },
                      child: Text(
                        webnotfound,
                        style: TextStyle(
                          color: webnotfound != "Show Hacked Website"
                              ? Colors.yellow
                              : const Color.fromARGB(255, 255, 0, 0),
                          fontSize: 40,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            SelectableText(
              content,
              showCursor: true,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
