import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';
import 'package:tailorine_mobilev2/provider/tailor_provider.dart';
import 'package:tailorine_mobilev2/screens/search_page.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';
import 'package:tailorine_mobilev2/widget/lainnya_card.dart';
import 'package:tailorine_mobilev2/widget/recommended_card.dart';

import '../models/user_model.dart';
import '../provider/auth_provider.dart';
import '../service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  bool selected = false;

  @override
  void initState() {
    super.initState();
    stickUserData();
    AuthService().getProfile();
    Future.microtask(() {
      Provider.of<TailorProvider>(
        context,
        listen: false,
      )
        ..getTailorPremiumV2()
        ..getTailornonPremiumV2();
    });
  }

  void stickUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var first_name = prefs.getString('first_name');
    var email = prefs.getString('email');
    var last_name = prefs.getString('last_name');
    var profile_picture = prefs.getString('profile_picture');
    if (first_name != null && last_name != null && profile_picture != null) {
      Provider.of<AuthProvider>(context, listen: false).user = UserModel(
        first_name: first_name,
        profile_picture: profile_picture,
        last_name: last_name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TailorProvider tailorProvider = Provider.of<TailorProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, ${user.first_name ?? ''}',
                      style: titleTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
                // FutureBuilder<UserModel>(
                //   future: AuthService().getProfile(),
                //   builder: (ctx, AsyncSnapshot snap) {
                //     if (snap.hasData) {
                //       return ClipOval(
                //         child: Image.network(
                //           snap.data.profile_picture,
                //           width: 50,
                //           height: 50,
                //           fit: BoxFit.cover,
                //           errorBuilder: (ctx, error, stackTrace) {
                //             return Image.asset(
                //               'assets/logo/logo_app.png',
                //               width: 50,
                //               height: 50,
                //               fit: BoxFit.cover,
                //             );
                //           },
                //         ),
                //       );
                //     } else if (snap.hasError) {
                //       return ClipOval(
                //         child: Image.asset(
                //           'assets/logo/logo_app.png',
                //           width: 50,
                //           height: 50,
                //           fit: BoxFit.cover,
                //         ),
                //       );
                //     }
                //     return Center(
                //       child: SizedBox(),
                //     );
                //   },
                // ),
              ],
            )
          ],
        ),
      );
    }

    Widget searchBar() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: 24,
          right: 24,
        ),
        child: Container(
          height: 48,
          child: Center(
            child: TextField(
              controller: searchController,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
              },
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Cari penjahit...',
                hintStyle: regularTextStyle.copyWith(color: Colors.grey, height: 3.8),
                suffixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget premiumTailors() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              top: 18,
            ),
            child: Row(
              children: [
                Text(
                  'Rekomendasi',
                  style: titleTextStyle.copyWith(fontSize: 24, fontWeight: semibold),
                ),
              ],
            ),
          ),
          Container(
            height: 260,
            child: Consumer<TailorProvider>(
              builder: (context, data, _) {
                final state = data.tailorPremiumState;
                final TailorResponseModel dataTailorPremium = data.tailorPremiumResponseModel;
                final TailorMetaModel meta = data.tailorPremiumMetaModel;
                if (state == CurrentState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == CurrentState.Success) {
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: dataTailorPremium.data!.map(
                      (tailor) {
                        return RecommendedCard(
                          tailor,
                        );
                      },
                    ).toList(),
                  );
                } else {
                  return Text("Failed State // Error // ${meta.message}");
                }
              },
            ),
          ),
        ],
      );
    }

    Widget lainnyaTailors() {
      return Container(
        margin: EdgeInsets.only(
          top: 18,
          left: 24,
          right: 24,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lainnya',
              style: titleTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            Consumer<TailorProvider>(
              builder: (context, data, _) {
                final state = data.tailorNonPremiumState;
                final TailorResponseModel dataTailorNonPremium = data.tailorNonPremiumResponseModel;
                final TailorMetaModel meta = data.tailorNonPremiumMetaModel;
                if (state == CurrentState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == CurrentState.Success) {
                  return Column(
                    children: dataTailorNonPremium.data!
                        .map(
                          (tailor) => LainnyaCard(tailor),
                        )
                        .toList(),
                  );
                } else {
                  return Text("Failed State // Error // ${meta.message}");
                }
              },
            ),
          ],
        ),
      );
    }

    Widget body() {
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(context),
              searchBar(),
              premiumTailors(),
              lainnyaTailors(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: body(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
