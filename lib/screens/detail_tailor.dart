import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/screens/appointment_screen.dart';
import 'package:tailorine_mobilev2/screens/catalogue_screen.dart';
import 'package:tailorine_mobilev2/widget/review_card.dart';

import '../models/tailor_model.dart';
import '../provider/tailor_provider.dart';
import '../shared/theme.dart';
import '../widget/advantage_card.dart';

class DetailTailor extends StatefulWidget {
  final TailorModel tailor;
  final String uuid;
  DetailTailor(this.tailor, this.uuid);
  @override
  State<DetailTailor> createState() => _DetailTailorState();
}

class _DetailTailorState extends State<DetailTailor> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    TailorProvider().getDetailTailor(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Stack(children: [
        Container(
          child: Column(
            children: [
              Image.network(
                widget.tailor.place_picture!,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 24,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/icons/back.png',
                  width: 32,
                  height: 32,
                ),
              ),
              // Icon(
              //   Icons.favorite,
              //   color: Colors.red,
              // ),
            ],
          ),
        ),
      ]);
    }

    Widget content() {
      return Container(
        //180 for top
        margin: EdgeInsets.only(top: 320),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            // NOTE: TITLE
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage(widget.tailor.profile_picture!),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.tailor.first_name! +
                            ' ' +
                            widget.tailor.last_name!,
                        style: regularTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semibold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
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
                              widget.tailor.rating ?? "name error",
                              style: regularTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 20,
                            width: 84,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                '1000 ulasan',
                                style: regularTextStyle.copyWith(
                                  color: primaryColor,
                                  fontSize: 10,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.zero,
                                onSurface: primaryColor,
                                side: BorderSide(
                                  width: 1.0,
                                  color: primaryColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          widget.tailor.is_premium!
                              ? Image.asset(
                                  'assets/icons/supertailor.png',
                                  width: 57,
                                  height: 21,
                                )
                              : SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Description',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                widget.tailor.description!,
                style: regularTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: normal,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            widget.tailor.is_premium!
                ? AdvatageCard(widget.tailor)
                : SizedBox(),
            // NOTE: LOCATION
            Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Location',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.tailor.address}',
                      style: regularTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.location_on),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Ulasan',
                    style: regularTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 20,
                  width: 84,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1000 ulasan',
                            style: regularTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: '',
                            style: regularTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                          TextSpan(
                            text: '>',
                            style: regularTextStyle.copyWith(
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size.zero, // Set this
                      padding: EdgeInsets.zero,
                      onSurface: primaryColor,
                      side: BorderSide(
                        width: 1.0,
                        color: primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),

            Padding(
              padding: EdgeInsets.only(left: 0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ReviewCard(),
                    SizedBox(
                      width: 0,
                    ),
                    ReviewCard(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          onSurface: primaryColor,
                          side: BorderSide(width: 1.0, color: primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Lihat Katalog',
                          style: regularTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: bold,
                              color: primaryColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatalogueScreen(
                                widget.tailor.uuid!,
                                widget.tailor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(
                                widget.tailor.uuid!,
                                widget.tailor,
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Buat janji temu',
                          style: regularTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: bgColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 40,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              header(),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
