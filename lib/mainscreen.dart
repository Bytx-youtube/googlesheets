import 'package:flutter/material.dart';
import 'package:untitled1/googlesheets.dart';
import 'package:untitled1/sheetscolumn.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController feedbackController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
              ),
              TextFormField(
                controller: countryController,
              ),
              TextFormField(
                controller: feedbackController,
              ),
              GestureDetector(
                onTap: () async {
                  final feedback = {
                    SheetsColumn.name: nameController.text.trim(),
                    SheetsColumn.country: countryController.text.trim(),
                    SheetsColumn.feedback: feedbackController.text.trim(),
                  };

                  await SheetsFlutter.insert([feedback]);
                },
                child: Container(
                  height: 70,
                  width: 400,
                  color: Colors.red,
                  child: Center(child: Text("Send to Sheets")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
