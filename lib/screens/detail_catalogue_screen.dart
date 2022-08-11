import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/provider/catalogue_provider.dart';

import '../models/catalogue_model.dart';
import '../shared/theme.dart';

class DetailCatalogueScreen extends StatefulWidget {
  final CatalogueModel catalogue;
  final String uuid;
  DetailCatalogueScreen(this.catalogue, this.uuid);
  @override
  State<DetailCatalogueScreen> createState() => _DetailCatalogueScreenState();
}

class _DetailCatalogueScreenState extends State<DetailCatalogueScreen> {
  bool isFavorite = false;
  int currentIndex = 0;
  @override
  void initState() {
    CatalogueProvider().getCatalogueDetail(widget.uuid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget header() {
      int index = -1;
      return Stack(
        children: [
          CarouselSlider(
            items: widget.catalogue.item!
                .map(
                  (image) => Image.network(
                    image.picture!,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              aspectRatio: 1 / 1,
              viewportFraction: 1,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 80,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.catalogue.item!.map((e) {
                index++;
                return indicator(index);
              }).toList(),
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
        ],
      );
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
          children: [
            // NOTE: HEADER
            Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 24,
                right: 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.catalogue.name!,
                          style: regularTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.catalogue.fabric!,
                          style: regularTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Harga mulai dari',
                        style: regularTextStyle.copyWith(fontSize: 12),
                      ),
                      Text(
                        'Rp. ${widget.catalogue.price!}',
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semibold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // NOTE: PRICE

            // NOTE: DESCRIPTION
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 30,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: regularTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semibold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.catalogue.description!,
                    style: regularTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Text(
                      'Barang Sejenis',
                      style: regularTextStyle.copyWith(
                          fontWeight: semibold, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 15,
                        bottom: 30,
                      ),
                      child: Row(
                        children: widget.catalogue.item!
                            .map(
                              (image) => Image.network(
                                image.picture!,
                                width: 108,
                                height: 129,
                                fit: BoxFit.cover,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
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
