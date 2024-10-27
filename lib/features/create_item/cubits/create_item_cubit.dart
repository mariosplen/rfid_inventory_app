import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';

part 'create_item_state.dart';

class CreateItemCubit extends Cubit<CreateItemState> {
  CreateItemCubit({
    required ItemModel item,
    required bool isEditing,
    String? selectedInventoryId,
  }) : super(
          CreateItemState.initial().copyWith(
            item: item,
            isEditing: isEditing,
            selectedInventoryId: selectedInventoryId,
          ),
        );

  final inventoriesBox = Hive.box<InventoryModel>("inventories");
  final model =
      FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash');

  void onEPCChanged(String value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(epc: value),
        inventoryError: state.inventoryError,
        nameError: state.nameError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        tagsError: state.tagsError,
      ),
    );
  }

  void onNameChanged(String value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(name: value),
        inventoryError: state.inventoryError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        tagsError: state.tagsError,
        epcError: state.epcError,
      ),
    );
  }

  void onCategoryChanged(String value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(category: value),
        inventoryError: state.inventoryError,
        nameError: state.nameError,
        colorError: state.colorError,
        tagsError: state.tagsError,
        epcError: state.epcError,
      ),
    );
  }

  void onImageChanged(String value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(image: value),
        inventoryError: state.inventoryError,
        nameError: state.nameError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        tagsError: state.tagsError,
        epcError: state.epcError,
      ),
    );
  }

  void onColorChanged(String value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(color: value),
        inventoryError: state.inventoryError,
        nameError: state.nameError,
        categoryError: state.categoryError,
        epcError: state.epcError,
        tagsError: state.tagsError,
      ),
    );
  }

  void onTagAdded(String value) {
    if (state.item.tags.contains(value)) return;
    emit(
      state.copyWith(
        item: state.item.copyWith(tags: [...state.item.tags, value]),
        nameError: state.nameError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        epcError: state.epcError,
        inventoryError: state.inventoryError,
      ),
    );
  }

  void onTagRemoved(int value) {
    emit(
      state.copyWith(
        item: state.item.copyWith(
          tags: List<String>.from(state.item.tags)..removeAt(value),
        ),
        nameError: state.nameError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        epcError: state.epcError,
        inventoryError: state.inventoryError,
      ),
    );
  }

  void onInventoryChanged(String? value) {
    emit(
      state.copyWith(
        selectedInventoryId: value,
        nameError: state.nameError,
        categoryError: state.categoryError,
        colorError: state.colorError,
        tagsError: state.tagsError,
        epcError: state.epcError,
      ),
    );
  }

  void onSubmitItem() {
    final (
      String? epcError,
      String? nameError,
      String? categoryError,
      String? colorError,
      String? tagsError,
      String? inventoryError
    ) = validate();

    if (epcError != null ||
        nameError != null ||
        categoryError != null ||
        colorError != null ||
        tagsError != null ||
        inventoryError != null) {
      emit(
        state.copyWith(
          epcError: epcError,
          nameError: nameError,
          categoryError: categoryError,
          colorError: colorError,
          tagsError: tagsError,
          inventoryError: inventoryError,
        ),
      );
      return;
    }

    if (state.isEditing) {
      _editInventory();
    } else {
      _addInventory();
    }
    emit(state.copyWith(success: true));
  }

  void _editInventory() {
    // remove the item from the first inventory it is found in
    final inventory = inventoriesBox.values.firstWhere(
      (inventory) => inventory.items.any((item) => item.epc == state.item.epc),
    );
    // remove the item from the inventory
    inventory.items.removeWhere((item) => item.epc == state.item.epc);
    // find the index of the inventory
    final index = inventoriesBox.values
        .toList()
        .indexWhere((inv) => inv.id == inventory.id);
    // update the inventory box
    inventoriesBox.putAt(index, inventory);

    // using the new inventory id find the new index
    final newIndex = inventoriesBox.values
        .toList()
        .indexWhere((inv) => inv.id == state.selectedInventoryId);
    // get the new inventory
    final newInventory = inventoriesBox.getAt(newIndex)!;
    // add the item to the new inventory
    newInventory.items.add(state.item);
    // update the inventory box
    inventoriesBox.putAt(newIndex, newInventory);
  }

  void _addInventory() {
    // using the new inventory id find the new index
    final newIndex = inventoriesBox.values
        .toList()
        .indexWhere((inv) => inv.id == state.selectedInventoryId);
    // get the new inventory
    final oldInventory = inventoriesBox.getAt(newIndex)!;
    // add the item to the new inventory
    final newInventory = oldInventory.copyWith(
      items: [...oldInventory.items, state.item],
    );
    // update the inventory box
    inventoriesBox.putAt(newIndex, newInventory);
  }

  void autoFill() async {
    if (state.item.image.isEmpty) {
      return;
    }
    emit(state.copyWith(isLoadingAIResult: true, aiError: false));
    try {
      final prompt = TextPart(
        "Answer me with ONLY a json response based on what you see on the image I provide you. Your next response should only in a json format with the following fields: name, category, color, tags. The Name should be a string representing the item you see, the Category should be a string representing the category of the item, the Color should be a string representing the color of the item, and the Tags should be a list of strings representing the tags of the item, also the tags should not contain any spaces. The colors can only be one of these: 'Black','White','Red','Green','Blue','Yellow','Orange','Purple','Pink','Brown','Grey', so try to pick the one which best corresponds to the item in the picture. The tags are some tags can help in filtering for example they could be the size and other very generic keywords that can be useful when filtering a lot of different items. Also do not add the ```json ``` thing that adds the formatting",
      );
      final image = await File(state.item.image).readAsBytes();
      final imagePart = DataPart('image/jpeg', image);

      final response = await model.generateContent(
        [
          Content.multi([prompt, imagePart]),
        ],
        generationConfig: GenerationConfig(),
      );
      if (response.text != null) {
        final responseMap = jsonDecode(response.text!);
        emit(
          state.copyWith(
            isLoadingAIResult: false,
            aiError: false,
            aiSuccess: true,
            item: state.item.copyWith(
              name: responseMap['name'],
              category: responseMap['category'],
              color: responseMap['color'],
              tags: List<String>.from(
                responseMap['tags'].map((tag) => tag.toString()).toList(),
              ),
            ),
          ),
        );
        emit(
          state.copyWith(
            aiSuccess: false,
          ),
        );
      } else {
        handleBadAutoFill();
      }
    } catch (e) {
      handleBadAutoFill();
    }
  }

  void handleBadAutoFill() {
    emit(
      state.copyWith(
        isLoadingAIResult: false,
        aiError: true,
        aiSuccess: false,
      ),
    );
    emit(state.copyWith(aiError: false));
  }

  (
    String? epcError,
    String? nameError,
    String? categoryError,
    String? colorError,
    String? tagsError,
    String? inventoryError
  ) validate() {
    String? epcError;
    String? nameError;
    String? categoryError;
    String? colorError;
    String? tagsError;
    String? inventoryError;

    if (state.item.epc.isEmpty) {
      epcError = "EPC cannot be empty";
    }

    if (state.item.name.isEmpty) {
      nameError = "Name cannot be empty";
    }

    if (state.item.category.isEmpty) {
      categoryError = "Category cannot be empty";
    }

    if (state.item.color.isEmpty) {
      colorError = "Color cannot be empty";
    }

    if (state.item.tags.isEmpty) {
      tagsError = "Tags cannot be empty";
    }

    if (state.selectedInventoryId == null) {
      inventoryError = "Inventory cannot be empty";
    }

    return (
      epcError,
      nameError,
      categoryError,
      colorError,
      tagsError,
      inventoryError
    );
  }

  final Map<ColorSwatch<Object>, String> colorToName = {
    ColorTools.primarySwatch(const Color(0xFF000000)): 'Black',
    ColorTools.primarySwatch(const Color(0xFFFFFFFF)): 'White',
    ColorTools.primarySwatch(const Color(0xFFFF0000)): 'Red',
    ColorTools.primarySwatch(const Color(0xFF00FF00)): 'Green',
    ColorTools.primarySwatch(const Color(0xFF0000FF)): 'Blue',
    ColorTools.primarySwatch(const Color(0xFFFFFF00)): 'Yellow',
    ColorTools.primarySwatch(const Color(0xFFFFA500)): 'Orange',
    ColorTools.primarySwatch(const Color(0xFF800080)): 'Purple',
    ColorTools.primarySwatch(const Color(0xFFFFC0CB)): 'Pink',
    ColorTools.primarySwatch(const Color(0xFFA52A2A)): 'Brown',
    ColorTools.primarySwatch(const Color(0xFF9E9E9E)): 'Grey',
  };

  final Map<String, String> colorStringToName = {
    "Color(0xff000000)": 'Black',
    "Color(0xffffffff)": 'White',
    "Color(0xffff0000)": 'Red',
    "Color(0xff00ff00)": 'Green',
    "Color(0xff0000ff)": 'Blue',
    "Color(0xffffff00)": 'Yellow',
    "Color(0xffffa500)": 'Orange',
    "Color(0xff800080)": 'Purple',
    "Color(0xffffc0cb)": 'Pink',
    "Color(0xffa52a2a)": 'Brown',
    "Color(0xff9e9e9e)": 'Grey',
  };

  final Map<String, Color> nameToColor = {
    'Black': const Color(0xff000000),
    'White': const Color(0xffffffff),
    'Red': const Color(0xffff0000),
    'Green': const Color(0xff00ff00),
    'Blue': const Color(0xff0000ff),
    'Yellow': const Color(0xffffff00),
    'Orange': const Color(0xffffa500),
    'Purple': const Color(0xff800080),
    'Pink': const Color(0xffffc0cb),
    'Brown': const Color(0xffa52a2a),
    'Grey': const Color(0xff9e9e9e),
  };
}
