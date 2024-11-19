import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ModelItem(this.id, this.title, this.imageUrl, {super.key});

  void selectModel(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      'CarsScreen',
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectModel(context),
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(
                  0.5), // Add a background for better text visibility
            ),
            child: Text(
              title,
              style: GoogleFonts.robotoCondensed(
                fontSize: 30,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
