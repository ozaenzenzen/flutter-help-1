import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/availability_model.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

class ClockCard extends StatefulWidget {
  // final AvailabilityModel? availability;
  // final Function(AvailabilityModel)? onTap;

  // final AvailabilityDateTimeModel? availability;
  final AvailabilityTimeModel? timeData;
  final Function(AvailabilityTimeModel)? onTap;
  final bool? isSelected;

  ClockCard({
    required this.timeData,
    required this.onTap,
    required this.isSelected,
  });
  @override
  State<ClockCard> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  // bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (widget.timeData!.booked!) {
            //
          } else {
            widget.onTap!(widget.timeData!);
            // setState(() {
            //   isSelected = !isSelected;
            // });
          }
        },
        child: widget.timeData!.time!.isNotEmpty
            ? Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 16,
                  right: 16,
                ),
                width: 85,
                height: 40,
                decoration: BoxDecoration(
                  color: widget.timeData!.booked!
                      ? Colors.grey.shade100
                      : widget.isSelected!
                          ? primaryColor
                          : bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: widget.timeData!.booked! ? Colors.grey.shade300 : primaryColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.timeData!.time!,
                    style: regularTextStyle.copyWith(
                      fontSize: 14,
                      color: widget.timeData!.booked!
                          ? Colors.grey.shade300
                          : widget.isSelected!
                              ? Colors.white
                              : textColor,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
