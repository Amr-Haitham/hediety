import 'package:flutter/material.dart';

import '../app_constants/app_measures.dart';
import 'date_picker_widget.dart';

class StartAndEndDatesPickerWidget extends StatefulWidget {
  DateTime selectedStartDate;
  DateTime selectedEndDate;
  final Function(DateTime) onStartDateSelected;
  final Function(DateTime) onEndDateSelected;
  StartAndEndDatesPickerWidget(
      {super.key,
      required this.selectedStartDate,
      required this.selectedEndDate,
      required this.onStartDateSelected,
      required this.onEndDateSelected});

  @override
  State<StartAndEndDatesPickerWidget> createState() =>
      _StartAndEndDatesPickerWidgetState();
}

class _StartAndEndDatesPickerWidgetState
    extends State<StartAndEndDatesPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  width:400,
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            // fit: FlexFit.tight,
            child: DatePickerFieldWidget(
              label: "Start Date *",
              onDateSelected: (date) {
                widget.selectedStartDate = date!;
                widget.onStartDateSelected(widget.selectedStartDate);
              },
            ),
          ),
          const SizedBox(width: AppMeasures.mediumBorderRadius12),
          Expanded(
            //fit: FlexFit.loose,
            child: DatePickerFieldWidget(
              label: "End Date *",
              onDateSelected: (date) {
                if (widget.selectedEndDate.isAfter(widget.selectedStartDate)) {
                  widget.selectedEndDate = date!;
                  widget.onEndDateSelected(widget.selectedEndDate);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Error"),
                      ),
                      content: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("End date must be after start date"),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
