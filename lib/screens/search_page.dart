import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/provider/tailor_provider.dart';
import '../models/tailor_model.dart';
import '../service/tailor_service.dart';
import '../shared/theme.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  // List<TailorModel>? allTailors;
  // List<TailorModel> _foundedTailors = [];

  void searchFunction(String search) {
    // setState(() {
    //   _foundedTailors = allTailors!.where((tailor) => tailor.first_name.toString().toLowerCase().contains(search)).toList();
    // });
    // print(search);
  }

  @override
  void initState() {
    super.initState();
    // TailorService().getAllTailor().then((value) {
    //   setState(() {
    //     allTailors = value;
    //     _foundedTailors = allTailors!;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: bgColor,
        title: Container(
          padding: EdgeInsets.only(
            right: 24,
          ),
          height: 48,
          child: Center(
            child: TextField(
              onChanged: (value) => searchFunction(value),
              textAlign: TextAlign.left,
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: bgColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Cari nama atau lokasi tailor',
                hintStyle: regularTextStyle.copyWith(color: Colors.grey, height: 3.8),
                suffixIcon: Icon(
                  Icons.search,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // margin: EdgeInsets.only(left: 24),
        child: Consumer<TailorProvider>(
          builder: (context, data, _) {
            final state = data.allTailorState;
            final TailorResponseModel dataAllTailor = data.allTailorResponseModel;
            final TailorMetaModel meta = data.allTailorMetaModel;
            if (state == CurrentState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == CurrentState.Success) {
              return ListView.builder(
                itemCount: dataAllTailor.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      dataAllTailor.data![index].firstName! + ' ' + dataAllTailor.data![index].lastName!,
                      style: regularTextStyle,
                    ),
                    subtitle: Text(dataAllTailor.data![index].city!),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        dataAllTailor.data![index].profilePicture!,
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("Failed State // Error // ${meta.message}");
            }
          },
        ),
        // child: FutureBuilder<List<TailorModel>>(
        //   future: TailorService().getAllTailor(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return _foundedTailors.isNotEmpty
        //           ? ListView.builder(
        //               itemCount: _foundedTailors.length,
        //               itemBuilder: (context, index) {
        //                 return ListTile(
        //                   title: Text(
        //                     _foundedTailors[index].first_name! +
        //                         ' ' +
        //                         _foundedTailors[index].last_name!,
        //                     style: regularTextStyle,
        //                   ),
        //                   subtitle: Text(_foundedTailors[index].city!),
        //                   leading: CircleAvatar(
        //                     backgroundImage: NetworkImage(
        //                       _foundedTailors[index].profile_picture!,
        //                     ),
        //                   ),
        //                 );
        //               },
        //             )
        //           : Center(
        //               child: Text('Tidak ada penjahit'),
        //             );
        //     } else if (snapshot.hasError) {
        //       return Center(
        //         child: Text("${snapshot.error}"),
        //       );
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
