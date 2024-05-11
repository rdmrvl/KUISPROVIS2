class item {
  final int id;
  final String title;
  final String description;
  final double price;
  final String img_name;

  item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.img_name,
  });
}

abstract class ItemState {}

class ItemListLoading extends ItemState {}

class ItemListLoaded extends ItemState {
  final List<item> items;

  ItemListLoaded({required this.items});
}

class ItemListError extends ItemState {
  final String message;

  ItemListError(this.message);
}