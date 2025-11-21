import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/category_cubit.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';

class CategoryStackPage extends StatelessWidget {
  final List<MenuModel> allMenu;

  const CategoryStackPage({super.key, required this.allMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Menu"),
        elevation: 4,
        backgroundColor: Colors.orange,
      ),
      body: BlocBuilder<CategoryCubit, String>(
        builder: (context, selectedCategory) {
          final filteredMenu = allMenu
              .where((m) => m.category == selectedCategory)
              .toList();

          return Stack(
            children: [
              // Kategori (atas)
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        categoryButton(context, "Makanan", Icons.fastfood),
                        categoryButton(context, "Minuman", Icons.local_drink),
                      ],
                    ),
                  ),
                ),
              ),

              // Daftar Menu (bawah) dengan animasi
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: ListView(
                    key: ValueKey(selectedCategory),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    children: filteredMenu
                        .map((menu) => MenuCard(menu: menu))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget categoryButton(BuildContext context, String category, IconData icon) {
    return BlocBuilder<CategoryCubit, String>(
      builder: (context, selected) {
        final isSelected = selected == category;
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.orange : Colors.grey[300],
            foregroundColor: isSelected ? Colors.white : Colors.black87,
            elevation: isSelected ? 6 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
          onPressed: () {
            context.read<CategoryCubit>().setCategory(category);
          },
          icon: Icon(icon, size: 20),
          label: Text(category, style: const TextStyle(fontSize: 16)),
        );
      },
    );
  }
}
