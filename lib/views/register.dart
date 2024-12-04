import 'package:e_library/views/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? username;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setRegisterPage(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", value);
  }

  getRegisterPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
    });
  }

  @override
  void initState() {
    super.initState();
    getRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 199, 218),
      ),
      child: Scaffold(backgroundColor: Colors.transparent, body: _page()),
    );
  }

  Widget _page() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Register for Explore',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          _nameField(namaController),
          const SizedBox(height: 15),
          _emailField(emailController),
          const SizedBox(height: 15),
          _usernameField(usernameController),
          const SizedBox(height: 15),
          _passwordField(passwordController, isPassword: true),
          const SizedBox(height: 20),
          _loginButton(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sudah punya akun? ',
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: const Text('Login',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 32, 106),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nameField(TextEditingController controller) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: namaController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: 'Nama Lengkap',
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: const Color.fromARGB(255, 255, 216, 229),
        filled: true,
        enabledBorder: border,
        focusedBorder: border,
        constraints: const BoxConstraints.tightFor(width: 350),
      ),
    );
  }

  Widget _emailField(TextEditingController controller) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: 'Eamil',
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: const Color.fromARGB(255, 255, 216, 229),
        filled: true,
        enabledBorder: border,
        focusedBorder: border,
        constraints: const BoxConstraints.tightFor(width: 350),
      ),
    );
  }

  Widget _usernameField(TextEditingController controller) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.black));
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: usernameController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        labelText: 'Username',
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: const Color.fromARGB(255, 255, 216, 229),
        filled: true,
        enabledBorder: border,
        focusedBorder: border,
        constraints: const BoxConstraints.tightFor(width: 350),
      ),
    );
  }

  Widget _passwordField(TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(color: Colors.black),
    );
    return TextField(
      style: const TextStyle(
        color: Colors.black,
      ),
      controller: passwordController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.black),
        fillColor: Color.fromARGB(255, 255, 216, 229),
        filled: true,
        enabledBorder: border,
        focusedBorder: border,
        constraints: const BoxConstraints.tightFor(width: 350),
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        backgroundColor: const Color.fromARGB(255, 255, 32, 106),
        shadowColor: Colors.white,
      ),
      onPressed: () {
        _autentikasi();
      },
      child: const Text(
        'Register',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _autentikasi() {
    String username = usernameController.text;
    String password = passwordController.text;
    String name = passwordController.text;
    String email = passwordController.text;
    if (name.isEmpty && email.isEmpty && username.isEmpty && password.isEmpty) {
      SnackBar snackBar = const SnackBar(
        content: Text("Field tidak boleh kosong!"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        setRegisterPage(username);
        Navigator.pop(context, MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      });
    }
  }
}

    



//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Hello, ${username ?? "Username"}!",
//             style: TextStyle(fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: textEditingController,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 if (textEditingController.text.isEmpty) {
//                   SnackBar snackBar =
//                       SnackBar(content: Text("Field tidak boleh kosong!"));
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 } else {
//                   setState(() {
//                     username = textEditingController.text;
//                     setRegisterPage(username!);
//                   });
//                 }
//               },
//               child: Text("Save"))
//         ],
//       ),
//     );
//   }
// }