import 'package:flutter/material.dart';
import 'package:myapp2/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as dynamic;
    final carImage = routeArguments['image'] ?? '';
    final carName = routeArguments['title'] ?? '';
    final carDesc = routeArguments['description'] ?? '';
    final carPrice = routeArguments['price'] ?? '';
    final carPriceString = carPrice.toString() + ' ' + 'USD';

    Future<void> _sendQuoteRequest() async {
      // Get user ID from SharedPreferences or any other method
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id') ?? '';

      if (userId.isNotEmpty) {
        try {
          var response = await AuthServices.sendQuoteRequest(
            userId: userId,
            carId: routeArguments['id'] ?? '',
            carName: carName,
            carPrice: carPrice,
          );

          if (response.statusCode == 200) {
            // Handle success
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Quote request sent successfully!')),
            );
          } else {
            // Handle failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to send quote request.\nSent Data: user_id=$userId, car_id=${routeArguments['id']}, car_name=$carName, car_price=$carPrice',
                ),
              ),
            );
          }
        } catch (e) {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: $e')),
          );
        }
      } else {
        // Handle missing user ID
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ID is missing.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(carName),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0, bottom: 16.0, right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "2024 - Edition",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 0),
            Center(
              child: Image.network(
                carImage,
                height: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    SizedBox(height: 4),
                    Text("Transmission"),
                    Text("Auto"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.battery_full, color: Colors.green),
                    SizedBox(height: 4),
                    Text("full charge"),
                    Text("500 km"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.people, color: Colors.red),
                    SizedBox(height: 4),
                    Text("Capacity"),
                    Text("5"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.speed, color: Color.fromARGB(255, 223, 204, 39)),
                    SizedBox(height: 4),
                    Text("0-100"),
                    Text("3.56 s"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              carDesc,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  carPriceString,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendQuoteRequest,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    "Quote Request",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
