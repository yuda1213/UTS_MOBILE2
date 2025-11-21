import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<String> {
  final List<String> categories = ["Makanan", "Minuman"];
  CategoryCubit() : super("Makanan");

  void setCategory(String category) {
    if (categories.contains(category)) {
      emit(category);
    }
  }

  List<String> getCategories() => categories;
}
