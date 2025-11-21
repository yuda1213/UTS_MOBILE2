import 'package:flutter/material.dart';
import '../models/menu_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class MenuCard extends StatelessWidget {
  final MenuModel menu;

  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon makanan/minuman
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.orange.shade100,
              child: Icon(
                menu.category == "Makanan" ? Icons.fastfood : Icons.local_drink,
                color: Colors.orange,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Rp ${menu.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Rp ${menu.getDiscountedPrice()}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
              ),
              onPressed: () {
                context.read<OrderCubit>().addToOrder(menu);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${menu.name} ditambahkan ke pesanan!"),
                    duration: const Duration(milliseconds: 800),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart, size: 18),
              label: const Text("Tambah"),
            ),
          ],
        ),
      ),
    );
  }
}
