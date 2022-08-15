import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';
import 'package:tailorine_mobilev2/screens/detail_tailor_screen.dart';

import '../screens/detail_tailor.dart';
import '../shared/theme.dart';

class RecommendedCard extends StatelessWidget {
  final TailorDataModel tailor;

  RecommendedCard(this.tailor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTailor(tailor, tailor.uuid!),
          ),
        );
      },
      child: Container(
        width: 164,
        height: 250,
        margin: EdgeInsets.only(
          // right: 0,
          top: 6,

          left: 24,
        ),
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
            Container(
              width: 128,
              height: 125,
              margin: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(tailor.placePicture ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tailor.firstName} ${tailor.lastName}',
                    style: titleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        tailor.district! + ',',
                        style: regularTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          tailor.city ?? "name error",
                          style: regularTextStyle.copyWith(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/star.png',
                        width: 14,
                        height: 14,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2.5,
                        ),
                        child: Text(
                          tailor.rating ?? "name error",
                          style: regularTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/icons/supertailor.png',
                        height: 18,
                        width: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
