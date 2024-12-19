import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/2_controller/add_pledge/add_pledge_cubit.dart';
import 'package:hediety/2_controller/get_pledge_status_for_gift/get_pledge_status_for_gift_cubit.dart';
import 'package:hediety/2_controller/gifts_blocs/set_gift_for_event/set_gift_for_event_cubit.dart';
import 'package:hediety/3_data_layer/models/gift.dart';
import 'package:hediety/3_data_layer/models/pledge.dart';
import 'package:hediety/core/utils/auth_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../../../core/utils/ui_utils.dart';

class GiftFormScreen extends StatefulWidget {
  final Gift? gift;
  final String eventId;

  final bool isMyGift;
  const GiftFormScreen(
      {Key? key,
      required this.gift,
      required this.eventId,
      required this.isMyGift})
      : super(key: key);

  @override
  State<GiftFormScreen> createState() => _GiftFormScreenState();
}

class _GiftFormScreenState extends State<GiftFormScreen> {
  Future<String?> processImage({
    required File imageFile,
    required BuildContext context,
  }) async {
    try {
      // Check file size (in bytes)
      final int fileSize = await imageFile.length();
      if (fileSize > 100 * 1024) {
        // Show error snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Image size exceeds 100KB. Please upload a smaller image.')),
        );
        return null;
      }

      // Read file and convert to Base64
      final bytes = await imageFile.readAsBytes();
      final base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      // Show error snack bar if something goes wrong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to process image: $e')),
      );
      return null;
    }
  }

  final _giftNameController = TextEditingController();
  final _giftDescriptionController = TextEditingController();
  final _giftCategoryController = TextEditingController();
  final _giftPriceController = TextEditingController();
  String? selectedImage;
  File? selectedImageFile;

  @override
  void initState() {
    if (widget.gift != null) {
      print(widget.gift?.imageUrl);
      print("halalalalal");
      _giftNameController.text = widget.gift!.name;
      _giftDescriptionController.text = widget.gift!.description;
      _giftCategoryController.text = widget.gift!.category;
      _giftPriceController.text = widget.gift!.price.toString();
      selectedImage = widget.gift!.imageUrl;
      if (widget.gift!.imageUrl != null) {
        (base64ToFile(widget.gift!.imageUrl!, "giftImage")).then((value) {
          setState(() {
            (selectedImageFile = value);
          });
        });
      }
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
          widget.isMyGift
              ? widget.gift == null
                  ? "Add Gift"
                  : "Edit Gift"
              : "View Gift",
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
                enabled: widget.isMyGift,
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
                enabled: widget.isMyGift,
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
                enabled: widget.isMyGift,
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
                enabled: widget.isMyGift,
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
                  ElevatedButton(
                    onPressed: () async {
                      await Permission.photos.request();

                      var image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      selectedImage = await processImage(
                        imageFile: File(image!.path),
                        context: context,
                      );
                      setState(() {
                        selectedImageFile = File(image!.path);
                      });
                    },
                    child: const Text(
                      "Add photo  ",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  !(widget.isMyGift)
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              selectedImageFile = null;
                              selectedImage = null;
                            });
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
                  image: DecorationImage(
                    image: FileImage(File(selectedImageFile?.path ?? "")),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // QR Code Section

              const SizedBox(height: 40),
              (!widget.isMyGift && widget.gift != null)
                  ? PledgeButton(
                      giftId: widget.gift!.id,
                      eventId: widget.eventId,
                    )
                  : const SizedBox(),
              !(widget.isMyGift)
                  ? const SizedBox()
                  : Center(
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
                                double.tryParse(_giftPriceController.text) !=
                                    null &&
                                selectedImage != null) {
                              BlocProvider.of<SetGiftForEventCubit>(context)
                                  .setGift(
                                      gift: Gift(
                                id: widget.gift != null
                                    ? widget.gift!.id
                                    : const Uuid().v4(),
                                name: _giftNameController.text,
                                description: _giftDescriptionController.text,
                                category: _giftCategoryController.text,
                                price: double.parse(_giftPriceController.text),
                                imageUrl: selectedImage,
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

class PledgeButton extends StatefulWidget {
  const PledgeButton({Key? key, required this.giftId, required this.eventId})
      : super(key: key);
  final String giftId;
  final String eventId;

  @override
  State<PledgeButton> createState() => _PledgeButtonState();
}

class _PledgeButtonState extends State<PledgeButton> {
  @override
  initState() {
    BlocProvider.of<GetPledgeStatusForGiftCubit>(context)
        .getPledgeStatusForGift(giftId: widget.giftId, eventId: widget.eventId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPledgeStatusForGiftCubit,
        GetPledgeStatusForGiftState>(
      builder: (context, state) {
        if (state is GetPledgeStatusForGiftLoading) {
          return const CircularProgressIndicator();
        }
        if (state is GetPledgeStatusForGiftError) {
          return const Text('Error');
        }
        var pledgeStatus =
            (state as GetPledgeStatusForGiftSuccess).pledgeStatus;
        return Center(
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
                if (pledgeStatus == PledgeStatus.pledged) {
                  return;
                }
                BlocProvider.of<AddPledgeCubit>(context).addPledge(
                    pledge: Pledge(
                        id: Uuid().v1(),
                        eventId: widget.eventId,
                        userId: AuthUtils.getCurrentUserUid(),
                        giftId: widget.giftId,
                        isFulfilled: false,
                        giftOwnerId: state.giftOnwerID));
                Navigator.pop(context);
              },
              child: Text(
                pledgeStatus == PledgeStatus.pledged
                    ? "Already Pledged"
                    : "Pledge",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<File?> base64ToFile(String base64Image, String fileName) async {
  try {
    // Decode the Base64 string to bytes
    final bytes = base64Decode(base64Image);

    // Get a temporary directory to store the file
    final directory = await getTemporaryDirectory();

    // Create the file in the directory
    final file = File('${directory.path}/$fileName');

    // Write the bytes to the file
    await file.writeAsBytes(bytes);

    return file; // Return the created file
  } catch (e) {
    print('Error converting Base64 to file: $e');
    return null;
  }
}
