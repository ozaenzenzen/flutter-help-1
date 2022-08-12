import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/models/appoinment_req_model.dart';
import 'package:tailorine_mobilev2/models/availability_model.dart';
import 'package:tailorine_mobilev2/models/user_model.dart';
import 'package:tailorine_mobilev2/provider/appointment_provider.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:tailorine_mobilev2/widget/clock_card.dart';
import '../models/tailor_model.dart';
import '../provider/auth_provider.dart';
import '../service/appointment_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';

class AppointmentScreen extends StatefulWidget {
  final String uuid;
  final TailorModel tailor;

  AppointmentScreen(this.uuid, this.tailor);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isLoading = false;
  bool isSelected = false;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final kToday = DateTime.now();
  AppointmentProvider? appointmentProvider;
  AuthProvider? authProvider;
  UserModel? user;

  int? _timeCardValue = 0;

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<AppointmentProvider>(
        context,
        listen: false,
      ).fetchAvailability(widget.uuid);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? _tempMessage;
  String? _tempTime;
  String? _tempDate;

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Padding(
        padding: const EdgeInsets.only(
          right: 24,
          left: 24,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Image.asset(
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
                child: Text(
                  'Buat janji temu',
                  style: titleTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          )
        ]),
      );
    }

    Widget tailorCard() {
      return Container(
        height: 114,
        margin: EdgeInsets.only(bottom: 12, top: 10, left: 24, right: 24),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 2),
          //     blurRadius: 15,
          //     color: Color(0xFF000000).withOpacity(0.06),
          //   ),
          // ],
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
                  image: NetworkImage(widget.tailor.place_picture ?? "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png"),
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
                    '${widget.tailor.first_name} ${widget.tailor.last_name}',
                    // "",
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
                        widget.tailor.district! + ',',
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
                            widget.tailor.city!,
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
                          widget.tailor.rating ?? "",
                          style: regularTextStyle.copyWith(color: secondaryColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // widget.tailor.is_premium!
                      //     ? Image.asset(
                      //         'assets/icons/supertailor.png',
                      //         height: 18,
                      //         width: 50,
                      //       )
                      //     : SizedBox(),
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
      );
    }

    Widget calendar() {
      return Container(
        //buat kotak putih
        margin: EdgeInsets.only(top: 10, left: 24, right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Pilih tanggal janji temu',
                style: titleTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            ),
            Consumer<AppointmentProvider>(
              builder: (context, data, _) {
                final state = data.currentState;
                final AvailabilityMetaModel meta = data.availabilityMetaModel;
                if (state == CurrentState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == CurrentState.Success) {
                  return TableCalendar(
                      headerStyle: HeaderStyle(
                        titleTextStyle: titleTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                        headerMargin: EdgeInsets.only(top: 10, bottom: 10),
                        leftChevronMargin: EdgeInsets.only(left: 0),
                        leftChevronPadding: EdgeInsets.only(left: 0),
                        rightChevronMargin: EdgeInsets.only(right: 0),
                        rightChevronPadding: EdgeInsets.only(right: 0),
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        context.read<AppointmentProvider>().chooseAvailability(selectedDay);
                        setState(() {
                          debugPrint("selectedDay ${selectedDay}");
                          debugPrint("focusedDay ${focusedDay}");
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;

                          _tempDate = selectedDay.toString();
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      });
                } else {
                  return Text("Failed State // Error // ${meta.message}");
                }
              },
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 24),
              child: Text(
                'Waktu yang tersedia',
                style: regularTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 16,
                ),
              ),
            ),
            //clock picker
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 24,
              ),
              height: 150,
              child: Consumer<AppointmentProvider>(
                builder: (context, data, child) {
                  final state = data.currentState;
                  final AvailabilityMetaModel meta = data.availabilityMetaModel;
                  debugPrint("current state: ${state}");
                  // debugPrint("data.listAvailability: ${data.listAvailability}");
                  if (state == CurrentState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == CurrentState.Success) {
                    return GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        mainAxisExtent: 40,
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                      ),
                      children: data.listAvailabilityTime
                          .mapIndexed((i, time) => ClockCard(
                                timeData: time,
                                value: i,
                                groupValue: _timeCardValue!,
                                onTap: (timeData, value) {
                                  setState(() {
                                    _timeCardValue = value;
                                    _tempTime = timeData.time.toString();
                                  });
                                  debugPrint("booked: ${timeData.booked}, time: ${timeData.time}");
                                },
                              ))
                          .toList(),
                    );
                  } else {
                    return Text("Failed State // Error // ${meta.message}");
                  }
                },
              ),
            ),

            //grid clock
          ],
        ),
      );
    }

    Widget clock() {
      return Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 24,
        ),
        height: 150,
        child: Consumer<AppointmentProvider>(
          builder: (context, data, child) {
            final state = data.currentState;
            final AvailabilityMetaModel meta = data.availabilityMetaModel;
            if (state == CurrentState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == CurrentState.Success) {
              return GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  mainAxisExtent: 40,
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                ),
                children: data.listAvailabilityTime
                    .mapIndexed((i, time) => ClockCard(
                          timeData: time,
                          value: i,
                          groupValue: _timeCardValue!,
                          onTap: (timeData, value) {
                            setState(() {
                              // isSelected = !isSelected;
                              _timeCardValue = value;
                            });
                            debugPrint("booked: ${timeData.booked}, time: ${timeData.time}");
                          },
                        ))
                    .toList(),
                // children: data.listAvailability
                //     .map((availability) => ClockCard(
                //           availability: availability,
                //           onTap: (availability) {
                //             debugPrint("availability ${availability.date}");
                //             debugPrint("time ${availability.time![0].booked} ${availability.time![0].time}");
                //           },
                //         ))
                //     .toList(),
              );
            } else {
              return Text("Failed State // Error // ${meta.message}");
            }
          },
        ),
        // child: FutureBuilder<List<AvailabilityModel>>(
        //   future: AppointmentService().fetchAvailability(widget.uuid),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return GridView(
        //         physics: NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           mainAxisSpacing: 10,
        //           mainAxisExtent: 40,
        //           crossAxisCount: 3,
        //           crossAxisSpacing: 15,
        //         ),
        //         children: snapshot.data!
        //             .map((availability) => ClockCard(
        //                   availability: availability,
        //                   onTap: (availability) {
        //                     debugPrint("availability ${availability.date}");
        //                     debugPrint("time ${availability.time![0].booked} ${availability.time![0].time}");
        //                   },
        //                 ))
        //             .toList(),
        //       );
        //     } else if (snapshot.hasError) {
        //       return Text("${snapshot.error}");
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
      );
    }

    Widget reviewField() {
      return Container(
        margin: EdgeInsets.only(top: 40, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pesan tambahan',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        // controller: firstnameController,
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                          hintStyle: regularTextStyle.copyWith(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget submit() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 20),
        child: TextButton(
          onPressed: () {
            AppointmentRequestModel appointmentRequestModel = AppointmentRequestModel(
              message: _tempMessage!,
              time: _tempTime!,
              date: _tempDate!,
              phone_number: user!.phone_number,
              first_name: user!.first_name,
              last_name: user!.last_name,
            );

            Provider.of<AppointmentProvider>(context).sendAppointment(appointmentRequestModel);
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Buat Janji Temu Sekarang!',
            style: regularTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: bgColor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              tailorCard(),
              calendar(),
              reviewField(),
              submit(),
            ],
          ),
        ),
      ),
    );
  }
}
