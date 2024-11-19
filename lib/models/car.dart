// ignore_for_file: non_constant_identifier_names

class car {
  final String id;
  final String category;
  final String carName;
  final String carImageurl;
  final String carDesc;
  final int carPrice;

  const car(
      {required this.id,
      required this.category,
      required this.carName,
      required this.carImageurl,
      required this.carDesc,
      required this.carPrice});

  // Factory method to create a Car from JSON
  factory car.fromJson(Map<String, dynamic> json) {
    return car(
      id: json['id']
          .toString(), // Assuming 'id' is an integer, converting to string
      category: json['model_id'].toString(),
      carName: json['carName'],
      carImageurl: "http://10.0.2.2:8000/storage/" + json['carImageurl'],
      carDesc: json['carDesc'],
      carPrice: json['carPrice'],
    );
  }
}
