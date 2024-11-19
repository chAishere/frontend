import 'package:flutter/material.dart';
import 'package:myapp2/models/models.dart';
import 'package:myapp2/services/auth.dart';

import '../widget/model_item.dart';

class ModelScreen extends StatelessWidget {
  const ModelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV CARS'),
      ),
      body: FutureBuilder<List<car_model>>(
        future: AuthServices.fetchCarModels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No car models available'));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 7 / 8,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                var modelData = snapshot.data![index];
                return ModelItem(
                  modelData.id,
                  modelData.title,
                  modelData.imageurl,
                );
              },
            );
          }
        },
      ),
    );
  }
}
