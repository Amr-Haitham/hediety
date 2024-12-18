import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/events/set_event/set_event_cubit.dart';
import 'package:hediety/core/utils/auth_utils.dart';
import 'package:hediety/core/widgets/date_picker_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../3_data_layer/models/event.dart';

class EventFormScreen extends StatefulWidget {
  final Event? event;

  const EventFormScreen({Key? key, this.event}) : super(key: key);

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _nameController.text = widget.event!.name;
      // _dateController.text = widget.event!.date;
      _locationController.text = widget.event!.location;
      _descriptionController.text = widget.event!.description;
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        id: widget.event?.id ?? Uuid().v1(),
        name: _nameController.text,
        date: Timestamp.fromDate(selectedDate ?? DateTime.now()),
        location: _locationController.text,
        description: _descriptionController.text,
        userId: AuthUtils.getCurrentUserUid(),
      );
      BlocProvider.of<SetEventCubit>(context).setEvent(newEvent);

      Navigator.pop(context, newEvent); // Returns the Event object.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Add Event' : 'Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              DatePickerFieldWidget(
                label: "enter event date",
                onDateSelected: (seletedDate) {
                  selectedDate = seletedDate;
                  setState(() {});
                },
              )
              // TextFormField(
              //   controller: _dateController,
              //   decoration: const InputDecoration(labelText: 'Date'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a date';
              //     }
              //     return null;
              //   },
              // ),
              ,
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // TextFormField(
              //   controller: _userIdController,
              //   decoration: const InputDecoration(labelText: 'User ID'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter a user ID';
              //     }
              //     if (int.tryParse(value) == null) {
              //       return 'User ID must be a number';
              //     }
              //     return null;
              //   },
              // ),
              const Spacer(),
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
