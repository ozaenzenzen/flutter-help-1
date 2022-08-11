import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';

import '../shared/theme.dart';

// ignore: must_be_immutable
class AdvatageCard extends StatelessWidget {
  TailorModel tailor;
  AdvatageCard(this.tailor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30.0,
        left: 24,
        right: 24,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15,
              right: 20,
              left: 18,
              bottom: 15,
            ),
            height: 125,
            width: double.infinity,
            margin: EdgeInsets.only(right: 34),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 15,
                  color: Color(0xFF000000).withOpacity(0.06),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Text(
                    tailor.first_name! + ' adalah Super Tailor',
                    style: regularTextStyle.copyWith(
                      fontWeight: semibold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: Text(
                    'Super Tailor adalah penjahit premium yang telah terverifikasi. Super Tailors adalah pilihan terbaik bagi Anda untuk mendapatkan kualiaitas layanan terbaik',
                    style: regularTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            heightFactor: 1.7,
            alignment: Alignment.centerRight,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: secondaryColor,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/icons/supertailor.png',
                width: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
