import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/availability_model.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

class ClockCard extends StatefulWidget {
  final AvailabilityModel? availability;
  final Function(AvailabilityModel)? onTap;

  ClockCard({
    required this.availability,
    required this.onTap,
  });
  @override
  State<ClockCard> createState() => _ClockCardState();
}

class _ClockCardState extends State<ClockCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          widget.onTap!(widget.availability!);
        },
        // onTap: () {
        //   setState(() {
        //     isSelected = !isSelected;
        //   });
        // },
        child: widget.availability!.time!.isNotEmpty
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
                  color: isSelected ? primaryColor : bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: primaryColor,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.availability!.time![0].time!,
                    style: regularTextStyle.copyWith(
                      fontSize: 14,
                      color: isSelected ? Colors.white : textColor,
                    ),
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
