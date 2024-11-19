import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp2/services/auth.dart';
import 'package:myapp2/widget/car_item.dart';
import 'package:myapp2/models/car.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final modelID = routeArguments?['id'] ?? '';
    final modelTitle = routeArguments?['title'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          modelTitle,
          style: GoogleFonts.robotoCondensed(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<car>>(
        future: AuthServices.fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars available'));
          } else {
            final filteredCars = snapshot.data!.where((car) {
              return car.category.contains(modelID);
            }).toList();

            return ListView.builder(
              itemCount: filteredCars.length,
              itemBuilder: (context, index) {
                return CarItem(
                  description: filteredCars[index].carDesc,
                  id: filteredCars[index].id,
                  name: filteredCars[index].carName,
                  imageUrl: filteredCars[index].carImageurl,
                  price: filteredCars[index].carPrice,
                );
              },
            );
          }
        },
      ),
    );
  }
}
