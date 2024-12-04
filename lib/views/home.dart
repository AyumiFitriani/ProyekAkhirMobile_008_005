
import 'dart:io';
import 'package:e_library/models/book_model.dart';
import 'package:e_library/presenters/book_presenter.dart';
import 'package:e_library/views/add_story_book.dart';
import 'package:e_library/views/boxes.dart';
import 'package:e_library/views/login.dart';
import 'package:e_library/views/story.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen(String username, {super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> implements BookView {
  late BookPresenter _presenter;
  bool _isLoading = false;
  List<Books> _bookList = [];
  String? _errorMessage;
  String _currentEndpoint = 'books';

  File? _image;
  final _usernameController = TextEditingController(text: " ");
  final _nameController = TextEditingController(text: " ");
  final _emailController = TextEditingController(text: " ");
  final _nomerhpController = TextEditingController(text: " ");

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    getLoginPage();
    super.initState();
    _presenter = BookPresenter(this);
    _presenter.loadbookdata(_currentEndpoint); // Memuat data saat awal
  }

  void _fetchData(String endpoint) {
    setState(() {
      _currentEndpoint = endpoint;
      _presenter.loadbookdata(endpoint); // Memuat data dengan endpoint yang dipilih
    });
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showBookList(List<Books> bookList) {
    setState(() {
      _bookList = bookList;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  final List<Map<String, dynamic>> friends = [
    {
      'nama': 'Ayumi Fitriani',
      'foto': 'assets/logo.png',
      'lastUpdate': '1 jam yang lalu',
      'content':
          'Akhirnyaa selesai juga baca buku Sebuah Seni Untuk Bersikap Bodo Amat.',
    },
    {
      'nama': 'Difta Wachidatur',
      'foto': 'assets/logo.png',
      'lastUpdate': '12 jam yang lalu',
      'content':
          'Seruu poll baca buku Laut Berceritaaa😍 Fix kalian harus coba, plot twist parahhh',
    },
    {
      'nama': 'Galuh Sischa',
      'foto': 'assets/logo.png',
      'lastUpdate': '1 hari yang lalu',
      'content': 'Aduhh terharu banget sama cerita di bukunya Dilan 1990:`)',
    }
  ];

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

 

  var height, width;
  List imgData = [
    "assets/logo.png",
    "assets/logo.png",
  ];

  List title = [
    "Healthy",
    "Konsultasi",
  ];

  int _selectedIndex = 0;

  get location => null;

  get index => null;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.black));
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();

    List<Widget> pages = <Widget>[
      //halaman home
      Scaffold(
          body: Container(
        color: const Color.fromARGB(255, 255, 216, 229),
        height: height,
        width: width,
        child: 
        Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    // color: const Color.fromARGB(255, 219, 225, 255),
                    ),
                height: height * 0.30,
                width: width,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 35, left: 25, right: 20),
                  ),
                  Text(
                    "Halooo, ${username ?? "Username"}!",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      labelText: 'Cari Buku Di Sini..',
                      labelStyle: const TextStyle(color: Colors.black),
                      fillColor: const Color.fromARGB(255, 255, 240, 245),
                      filled: true,
                      enabledBorder: border,
                      focusedBorder: border,
                      constraints:
                          const BoxConstraints.tightFor(width: 350, height: 45),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Image.asset(
                    "assets/logo.png",
                    height: 120,
                    width: 120,
                  ),
                ])),
            Container(
              
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 240, 245),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: height * 0.635,
              width: width,
              child: _isLoading
              ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text("Error : $_errorMessage"))
                    :
              GridView.builder(
                  padding: const EdgeInsets.only(top: 65, left: 25, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 25),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _bookList.length,
                  itemBuilder: (context, index) {
                    final book = _bookList[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 255, 216, 229),
                            boxShadow: const [
                              // BoxShadow(
                              //   color: Color.fromARGB(255, 2, 50, 88),
                              //   spreadRadius: 1,
                              //   blurRadius: 7,
                              // ),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: book.cover.isNotEmpty
                                ? Image.asset(book.cover)
                                : Image.network('https://placehold.co/600x400'),
                              width: 90,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 240, 245),
                                ),
                                onPressed: () {
                                  // _navigation(index);
                                },
                                child: Text(
                                  book.title,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 83, 83, 83),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      )),

      //halaman book story
      Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.people),
          title: const Text(
            'Story Book',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 199, 218),
        ),
        backgroundColor:
            const Color.fromARGB(255, 255, 240, 245), // Background penuh
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Story>(HiveBoxes.story).listenable(),
            builder: (context, Box<Story> box, _) {
              if (box.values.isEmpty) {
                return Center(
                  child: Text("Belum ada yang membagikan cerita."),
                );
  
              }
              return GridView.builder(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, mainAxisExtent: 200),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    final fren = friends[index];
                    Story? res = box.getAt(index);
                    return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          res!.delete();
                        },
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(255, 255, 199, 218),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12),
                                child: Column(children: [
                                  Row(children: [
                                    Image.asset("assets/logo.png",
                                        height: 50, width: 50),
                                    Text(
                                      '$username',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      fren['lastUpdate'],
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: const Color.fromARGB(
                                              255, 78, 78, 78)),
                                    ),
                                  ]),
                                  const SizedBox(height: 10),
                                  Text(
                                    res!.content,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ])),
                          ),
                        ));
                  });
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 255, 216, 229),
            tooltip: 'Add Story',
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddBookStory()));
            }),
      ),

      //halaman profile
      Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color.fromARGB(255, 255, 199, 218),
          ),
          body: Container(
              decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 240, 245),
          ),
           padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage(''),
                onBackgroundImageError: (_, __) {
                  // Tambahkan fallback jika gambar default gagal dimuat
                  print("Error loading default image");
                },
                backgroundColor: Colors.grey[200],
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text(
                  "Pilih Foto",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 32, 106),
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                  controller: _usernameController, label: 'Username'),
              const SizedBox(height: 20),
              _buildTextField(controller: _nameController, label: 'Nama'),
              const SizedBox(height: 20),
              _buildTextField(controller: _emailController, label: 'Email'),
              const SizedBox(height: 20),
              _buildTextField(
                  controller: _nomerhpController, label: 'Nomor Telepon'),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 32, 106),
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                ),
              ),
     ] ),
        ),
      ),
      
    ),    
     
    ];

    return Scaffold(
        body: Center(
          child: pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(255, 83, 83, 83),
          selectedItemColor: const Color.fromARGB(255, 255, 32, 106),
          backgroundColor: const Color.fromARGB(255, 255, 216, 229),
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Story'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 199, 218),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    );
  }
}