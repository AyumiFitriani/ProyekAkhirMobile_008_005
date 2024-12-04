import 'package:e_library/models/book_model.dart';
import 'package:e_library/network/base_network.dart';

abstract class BookView {
  void showLoading();
  void hideLoading();
  void showBookList(List<Books> bookList);
  void showError(String message);
}

class BookPresenter {
  final BookView view;
  BookPresenter(this.view);

 Future<void> loadbookdata(String endpoint) async {
  try {
    view.showLoading();
    final dynamic data = await BaseNetwork.getData(endpoint);

    // Periksa apakah data berupa List
    if (data is List) {
      // Map data menjadi List<Books>
      final bookList = data
          .map((item) => Books.fromJson(item as Map<String, dynamic>))
          .toList();

      view.showBookList(bookList);
    } else {
      throw Exception('Unexpected data format. Expected List<dynamic>.');
    }
  } catch (e) {
    view.showError('Failed to load books: $e');
  } finally {
    view.hideLoading();
  }
}
}