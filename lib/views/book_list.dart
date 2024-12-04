import 'package:e_library/models/book_model.dart';
import 'package:e_library/presenters/book_presenter.dart';
import 'package:flutter/material.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> implements BookView {
  late BookPresenter _presenter;
  bool _isLoading = false;
  List<Books> _bookList = [];
  String? _errorMessage;
  String _currentEndpoint = 'books';

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book List"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _fetchData('books'),
                  child: Text("Load Books")),
            ],
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text("Error : $_errorMessage"))
                    : ListView.builder(
                        itemCount: _bookList.length,
                        itemBuilder: (context, index) {
                          final book = _bookList[index];
                          return ListTile(
                            leading: book.cover.isNotEmpty
                                ? Image.asset(book.cover)
                                : Image.network('https://placehold.co/600x400'),
                            title: Text(book.title),
                            subtitle: Text('Published: ${book.tahunTerbit}'),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
