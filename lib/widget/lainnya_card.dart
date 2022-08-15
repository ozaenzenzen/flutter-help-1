import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';
import '../screens/detail_tailor.dart';
import '../screens/detail_tailor_screen.dart';

class LainnyaCard extends StatelessWidget {
  // final JobModel job;

  final TailorDataModel tailor;
  LainnyaCard(this.tailor);

  // JobTile(this.job);

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
        height: 114,
        margin: EdgeInsets.only(bottom: 12, top: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 15,
              color: Color(0xFF000000).withOpacity(0.06),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(right: 18, top: 18, bottom: 18, left: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(tailor.placePicture ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    '${tailor.firstName} ${tailor.lastName}',
                    style: titleTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 2,
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Text(
                            tailor.city!,
                            style: regularTextStyle.copyWith(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
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
                        padding: const EdgeInsets.only(top: 2.5),
                        child: Text(
                          tailor.rating.toString(),
                          style: regularTextStyle.copyWith(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  // Divider(
                  //   thickness: 1,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
