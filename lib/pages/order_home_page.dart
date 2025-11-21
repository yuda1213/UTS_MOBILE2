import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';
import '../widgets/menu_card.dart';
import '../blocs/order_cubit.dart';
import '../blocs/category_cubit.dart';
import 'order_summary_page.dart';
import 'category_stack_page.dart';

class OrderHomePage extends StatelessWidget {
  OrderHomePage({super.key});

  // Contoh data menu (bisa kamu ganti nanti)
  final List<MenuModel> dummyMenu = [
    MenuModel(
      id: "1",
      name: "Nasi Goreng",
      price: 25000,
      category: "Makanan",
      discount: 0.1,
    ),
    MenuModel(
      id: "2",
      name: "Mie Ayam",
      price: 20000,
      category: "Makanan",
      discount: 0.05,
    ),
    MenuModel(
      id: "3",
      name: "Es Teh",
      price: 8000,
      category: "Minuman",
      discount: 0.2,
    ),
    MenuModel(
      id: "4",
      name: "Es Jeruk",
      price: 10000,
      category: "Minuman",
      discount: 0.1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Menu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderSummaryPage()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          // Tombol kategori (Stack halaman terpisah)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryStackPage(allMenu: dummyMenu),
                  ),
                );
              },
              child: const Text("Pilih Kategori (Stack Page)"),
            ),
          ),

          const SizedBox(height: 8),

          // Daftar menu default (langsung tampil semua)
          Expanded(
            child: ListView(
              children: dummyMenu.map((menu) => MenuCard(menu: menu)).toList(),
            ),
          ),
        ],
      ),

      floatingActionButton: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderSummaryPage()),
              );
            },
            label: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Subtotal: Rp ${state.subtotal}",
                  style: const TextStyle(fontSize: 12),
                ),
                if (state.discount > 0)
                  Text(
                    "Diskon: -Rp ${state.discount}",
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                Text(
                  "Total: Rp ${state.total}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            icon: const Icon(Icons.shopping_cart),
          );
        },
      ),
    );
  }
}
