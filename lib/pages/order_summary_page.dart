import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/order_cubit.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ringkasan Pesanan")),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          final items = state.items;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: items.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key.name),
                        subtitle: Text(
                          "Qty: ${entry.value} | Rp ${entry.key.getDiscountedPrice()}",
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const Divider(),

                if (state.discount > 0)
                  Text(
                    "Diskon 10%: -Rp ${state.discount}",
                    style: const TextStyle(color: Colors.green),
                  ),
                if (state.discount == 0 && state.subtotal < 100000)
                  const Text("Total belum mencapai diskon 10%"),

                const SizedBox(height: 8),

                Text(
                  "Subtotal: Rp ${state.subtotal}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Total Bayar: Rp ${state.total}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    context.read<OrderCubit>().clearOrder();
                    Navigator.pop(context);
                  },
                  child: const Text("Selesai"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
