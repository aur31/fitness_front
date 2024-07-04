
class Component {
  String? component_id;
  String? image;
  String? name;

  Component.EmptyUser();
  Component({
    required this.component_id,
    required this.image,
    required this.name,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      component_id: json['component_id'],
      image: json['image'],
      name: json['name'] ?? "",
    );
  }
}
