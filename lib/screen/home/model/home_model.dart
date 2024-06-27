class HomeModel {
  String? name;
  String? image;
  String? position;
  String? velocity;
  String? distance;
  String? description;

  HomeModel(
      {this.name,
      this.image,
      this.position,
      this.velocity,
      this.distance,
      this.description});

  factory HomeModel.mapToModel(Map m1) {
    return HomeModel(
      name: m1['name'],
      image: m1['image'],
      position: m1['position'],
      velocity: m1['velocity'],
      distance: m1['distance'],
      description: m1['description'],
    );
  }
}
