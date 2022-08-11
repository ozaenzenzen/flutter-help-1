import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/screens/detail_catalogue_screen.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

import '../models/catalogue_model.dart';

class CatalogueCard extends StatelessWidget {
  final CatalogueModel catalogue;
  CatalogueCard(this.catalogue);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailCatalogueScreen(catalogue, catalogue.uuid!),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                catalogue.item![0].picture!,
                height: 200,
                width: 156,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              catalogue.name!,
              style: titleTextStyle.copyWith(
                  fontWeight: semibold, fontSize: 18, color: textColor),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              catalogue.price!,
              style: titleTextStyle.copyWith(
                  fontWeight: normal, fontSize: 12, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
