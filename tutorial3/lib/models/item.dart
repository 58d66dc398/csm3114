import 'category.dart';

class Item {
  final String id, name;
  final int quantity;
  final Category category;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });
}
