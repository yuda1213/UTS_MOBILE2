import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

class OrderState {
  final Map<MenuModel, int> items; // menu + qty
  final int subtotal;
  final int discount;
  final int total;

  OrderState({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
  });

  factory OrderState.initial() {
    return OrderState(items: {}, subtotal: 0, discount: 0, total: 0);
  }

  OrderState copyWith({
    Map<MenuModel, int>? items,
    int? subtotal,
    int? discount,
    int? total,
  }) {
    return OrderState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState.initial());

  void addToOrder(MenuModel menu) {
    final newItems = Map<MenuModel, int>.from(state.items);
    if (newItems.containsKey(menu)) {
      newItems[menu] = newItems[menu]! + 1;
    } else {
      newItems[menu] = 1;
    }
    _emitWithCalculation(newItems);
  }

  void removeFromOrder(MenuModel menu) {
    final newItems = Map<MenuModel, int>.from(state.items);
    newItems.remove(menu);
    _emitWithCalculation(newItems);
  }

  void updateQuantity(MenuModel menu, int qty) {
    final newItems = Map<MenuModel, int>.from(state.items);
    if (qty <= 0) {
      newItems.remove(menu);
    } else {
      newItems[menu] = qty;
    }
    _emitWithCalculation(newItems);
  }

  void clearOrder() {
    emit(OrderState.initial());
  }

  void _emitWithCalculation(Map<MenuModel, int> items) {
    int subtotal = 0;
    items.forEach((menu, qty) {
      subtotal += menu.getDiscountedPrice() * qty;
    });
    int discount = 0;
    int total = subtotal;
    if (subtotal > 100000) {
      discount = (subtotal * 0.1).toInt();
      total = subtotal - discount;
    }
    emit(
      OrderState(
        items: items,
        subtotal: subtotal,
        discount: discount,
        total: total,
      ),
    );
  }
}
