
import 'package:e_library/views/boxes.dart';
import 'package:e_library/views/home.dart';
import 'package:e_library/views/story.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBookStory extends StatefulWidget {
  const AddBookStory({super.key});

  @override
  State<AddBookStory> createState() => _AddBookStoryState();
}

class _AddBookStoryState extends State<AddBookStory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController contentController = TextEditingController();

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _onFromSubmit();
      print("form validated");
    } else {
      print("form not validated");
      return;
    }
  }

  void _onFromSubmit() {
    Box<Story> storyBox = Hive.box<Story>(HiveBoxes.story);
    storyBox.add(Story(content: contentController.text));
    print("Story added: ${contentController.text}");
    Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (context) => HomePageScreen(username ?? 'Username')));
    print(storyBox);
  }

  late String nama;
  late String lastUpdate;
  late String content;
  String? username;

  setLoginPage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", value);
  }

  getLoginPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    var height, width;
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.black));
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Book Story',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 199, 218),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 240, 245),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              children: [
                // const Padding(padding: EdgeInsets.all(15.0)),
                const SizedBox(height: 18),
                const Text(
                  'Bagikan Pengalaman Membaca Bukumu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "$username",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    content = value;
                  },
                  autofocus: false,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: contentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Bagikan ceritamu ...',
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: const Color.fromARGB(255, 255, 240, 245),
                    filled: true,
                    enabledBorder: border,
                    focusedBorder: border,
                    constraints:
                        const BoxConstraints.tightFor(width: 350, height: 150),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 18),
                    backgroundColor: const Color.fromARGB(255, 255, 32, 106),
                    shadowColor: Colors.white,
                  ),
                  onPressed: () {
                    validated();
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePageScreen(username!)));
                  },
                  child: const Text(
                    'Upload',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}