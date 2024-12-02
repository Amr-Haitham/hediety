import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/gifts_blocs/set_gift_for_event/set_gift_for_event_cubit.dart';
import 'package:hediety/3_model/models/gift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/ui_utils.dart';

class GiftFormScreen extends StatefulWidget {
  final Gift? gift;
  final String eventId;
  const GiftFormScreen({Key? key, required this.gift, required this.eventId})
      : super(key: key);

  @override
  State<GiftFormScreen> createState() => _GiftFormScreenState();
}

class _GiftFormScreenState extends State<GiftFormScreen> {
  final _giftNameController = TextEditingController();
  final _giftDescriptionController = TextEditingController();
  final _giftCategoryController = TextEditingController();
  final _giftPriceController = TextEditingController();
  @override
  void initState() {
    if (widget.gift != null) {
      _giftNameController.text = widget.gift!.name;
      _giftDescriptionController.text = widget.gift!.description;
      _giftCategoryController.text = widget.gift!.category;
      _giftPriceController.text = widget.gift!.price.toString();
    }
    super.initState();
  }

  // final Gift fadfa = Gift(
  //     id: "",
  //     name: "",
  //     description: "",
  //     category: "",
  //     price: 0,
  //     status: "",
  //     eventId: event);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          widget.gift == null ? "Add Gift" : "Edit Gift",
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Item Name Input
              const Text(
                "Item name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _giftNameController,
                decoration: InputDecoration(
                  hintText: "Item name",
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description Input
              const Text(
                "Description   (optional)",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _giftDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Description",
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description Input
              const Text(
                "Category",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _giftCategoryController,
                // maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Category",
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description Input
              const Text(
                "Price",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _giftPriceController,
                // maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Price",
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Add Photo Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add photo   (optional)",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle photo delete action
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/300x150"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // QR Code Section
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Or",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.qr_code, size: 50, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Add Button
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      if (_giftNameController.text.isNotEmpty &&
                          _giftDescriptionController.text.isNotEmpty &&
                          _giftCategoryController.text.isNotEmpty &&
                          _giftPriceController.text.isNotEmpty &&
                          double.tryParse(_giftPriceController.text) != null) {
                        BlocProvider.of<SetGiftForEventCubit>(context).setGift(
                            gift: Gift(
                          id: widget.gift != null
                              ? widget.gift!.id
                              : const Uuid().v4(),
                          name: _giftNameController.text,
                          description: _giftDescriptionController.text,
                          category: _giftCategoryController.text,
                          price: double.parse(_giftPriceController.text),
                          imageUrl: widget.gift?.imageUrl,
                          eventId: widget.eventId,
                          status: GiftStatus.unpledged,
                        ));
                      } else {
                        UiUtils.showSnackBar(
                            context: context,
                            text:
                                "Please fill all the fields with valid values");
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      widget.gift != null ? "Update" : "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
