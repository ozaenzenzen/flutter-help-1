import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/availability_model.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

class ClockCard extends StatefulWidget {
  final AvailabilityTimeModel? timeData;
  final int value;
  final dynamic groupValue;
  final void Function(AvailabilityTimeModel data, int)? onTap;

  ClockCard({
    required this.timeData,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  @override
  State<ClockCard> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.value == widget.groupValue;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (widget.timeData!.booked! == false) {
            widget.onTap!(widget.timeData!, widget.value);
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
                      : isSelected
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
                          : isSelected
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
