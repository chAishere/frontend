class car_model {
  final String id;
  final String title;
  final String imageurl;

  const car_model(
      {required this.id, required this.title, required this.imageurl});

  factory car_model.fromJson(Map<String, dynamic> json) {
    //var urlimg = Uri.parse('http://10.0.2.2:8000/storage/');
    return car_model(
      id: json['id']
          .toString(), // Assuming 'id' is an integer, converting to string
      title: json['title'],
      imageurl: "http://10.0.2.2:8000/storage/" + json['image'],
    );
  }
}
