// import 'package:e_library/models/book_model.dart';
// import 'package:e_library/presenters/book_presenter.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'login.dart';

// class DetailPage extends StatefulWidget {
//   @override
//   _DetailPageState createState() => _DetailPageState();
// }
// class _DetailPageState extends State<DetailPage> implements BookView {
//   late BookPresenter _presenter;
//   bool _isLoading = false;
//   List<Books> _bookList = [];
//   String? _errorMessage;
//   String _currentEndpoint = 'books';

//    @override
//   void initState() {
//     super.initState();
//     super.initState();
//     _presenter = BookPresenter(this);
//     _presenter.loadbookdata(_currentEndpoint); // Memuat data saat awal
//   }

//   void _fetchData(String endpoint) {
//     setState(() {
//       _currentEndpoint = endpoint;
//       _presenter.loadbookdata(endpoint); // Memuat data dengan endpoint yang dipilih
//     });
//   }

//   @override
//   void showLoading() {
//     setState(() {
//       _isLoading = true;
//     });
//   }

//   @override
//   void hideLoading() {
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void showBookList(List<Books> bookList) {
//     setState(() {
//       _bookList = bookList;
//     });
//   }

//   @override
//   void showError(String message) {
//     setState(() {
//       _errorMessage = message;
//     });
//   }
  


//   @override
//   Widget build(BuildContext context, index) {
//     final book = _bookList[index];
//     return Scaffold(
//       appBar: AppBar(
     
//         title: const Text(
//           'Detail Buku',
//           style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//         ),
//         backgroundColor: const Color.fromARGB(255, 255, 199, 218),
//       ),
//       body: Container(
        
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 255, 240, 245),
//         ),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
          
//           children: [
            
//             Container(
//                               child: book.cover.isNotEmpty
//                                 ? Image.asset(book.cover)
//                                 : Image.network('https://placehold.co/600x400'),
//                               width: 90,
//                             ),
//                             SizedBox(height: 20,),
            
//             Text(book.title),
//             SizedBox(height: 12,),
//             Text(book.sinopsis),
            
//           ],
          
//         ),

//   ));}}
       