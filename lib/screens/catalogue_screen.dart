import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tailorine_mobilev2/provider/catalogue_provider.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

import '../models/catalogue_model.dart';
import '../models/tailor_model.dart';
import '../widget/catalogue_card.dart';

class CatalogueScreen extends StatefulWidget {
  final String uuid;
  final TailorModel tailor;

  CatalogueScreen(this.uuid, this.tailor);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    CatalogueProvider catalogueProvider =
        Provider.of<CatalogueProvider>(context);

    Widget getUpper() {
      return Padding(
        padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: FutureBuilder<List<CatalogueModel>>(
              future: catalogueProvider.getUpper(widget.uuid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return catalogueProvider.getUpper(widget.uuid) == true
                      ? Column(
                          children: [
                            Icon(Icons.warning_amber_sharp, size: 50),
                            Text('data kosong'),
                          ],
                        )
                      : GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 270,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.map(
                            (catalogue) {
                              return CatalogueCard(
                                catalogue,
                              );
                            },
                          ).toList(),
                        );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Icon(Icons.warning_amber_sharp, size: 50),
                      Text('Penjahit ini belum memiliki katalog'),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      );
    }

    Widget getLower() {
      return Padding(
        padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: FutureBuilder<List<CatalogueModel>>(
              future: catalogueProvider.getLower(widget.uuid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return catalogueProvider.getLower(widget.uuid) == false
                      ? Column(
                          children: [
                            Icon(Icons.warning_amber_sharp, size: 50),
                            Text('Penjahit ini belum memiliki katalog'),
                          ],
                        )
                      : GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 270,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                          ),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.map(
                            (catalogue) {
                              return CatalogueCard(
                                catalogue,
                              );
                            },
                          ).toList(),
                        );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Icon(Icons.warning_amber_sharp, size: 50),
                      Text('Penjahit ini belum memiliki katalog'),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      );
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.only(right: 24, left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/icons/back.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Catalogue Screen',
                      style: titleTextStyle.copyWith(
                          fontSize: 20, fontWeight: semibold),
                    ),
                  ),
                ),
                const SizedBox(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.tailor.first_name!,
                      style: titleTextStyle.copyWith(
                          fontSize: 18, fontWeight: semibold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    widget.tailor.is_premium!
                        ? Image.asset(
                            'assets/icons/supertailor.png',
                            width: 57,
                            height: 21,
                          )
                        : const SizedBox(),
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: primaryColor,
                  backgroundImage: NetworkImage(widget.tailor.profile_picture!),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Padding(
        padding: const EdgeInsets.only(top: 20, right: 24, left: 24),
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          child: FutureBuilder<List<CatalogueModel>>(
              future: catalogueProvider.getCatalogueByTailor(widget.uuid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 270,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                    ),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.map(
                      (catalogue) {
                        return CatalogueCard(
                          catalogue,
                        );
                      },
                    ).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Icon(Icons.warning_amber_sharp, size: 50),
                      Text('Penjahit ini belum memiliki katalog'),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: ButtonsTabBar(
                          contentPadding: EdgeInsets.all(10),
                          tabs: [
                            Tab(
                              child: Text(
                                'Semua',
                                style: regularTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: medium,
                                    color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Atasan',
                                style: regularTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: medium,
                                    color: Colors.white),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Bawahan',
                                style: regularTextStyle.copyWith(
                                    fontSize: 13,
                                    fontWeight: medium,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: TabBarView(
                          children: [
                            body(),
                            getUpper(),
                            getLower(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
