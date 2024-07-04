
class Menu {
  String? menu_id;
  String? recipe;
  String? meal;
  String? image;

  Menu.EmptyUser();
  Menu({
    required this.menu_id,
    required this.recipe,
    required this.meal,
    required this.image,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menu_id: json['menu_id'],
      recipe: json['recipe'],
      meal: json['meal'],
      image: json['image'],
    );
  }
}
