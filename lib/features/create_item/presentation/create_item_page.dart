import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rfid_inventory_app/core/cubits/reader/reader_cubit.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/core/models/item_model.dart';
import 'package:rfid_inventory_app/core/models/rfid_model.dart';
import 'package:rfid_inventory_app/core/presentation/utils/snackbar_util.dart';
import 'package:rfid_inventory_app/features/create_item/cubits/create_item_cubit.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class CreateItemPage extends StatefulWidget {
  const CreateItemPage({
    this.item,
    this.rfidModel,
    super.key,
  });

  final ItemModel? item;
  final RFIDModel? rfidModel;

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
    _nameController.text = widget.item?.name ?? '';
    _categoryController.text = widget.item?.category ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allInventories =
        context.read<InventoriesCubit>().state.inventories ?? [];
    final menuEntries = allInventories
        .map(
          (inventory) => DropdownMenuEntry(
            value: inventory.id,
            label: inventory.name,
          ),
        )
        .toList();
    final selectedEntry =
        _getSelectedEntry(context, allInventories, widget.item);

    return BlocProvider(
      create: (context) => CreateItemCubit(
        item: (widget.item ??
                ItemModel.empty().copyWith(epc: widget.rfidModel?.epc))
            .copyWith(color: 'Black'),
        isEditing: widget.item != null,
        selectedInventoryId: selectedEntry,
      ),
      child: BlocConsumer<CreateItemCubit, CreateItemState>(
        listener: (context, state) {
          if (state.success) {
            context.read<InventoriesCubit>().loadInventories();
            context.router.maybePop();
          }
          // show/hide loading overlay
          if (state.isLoadingAIResult) {
            context.loaderOverlay.show();
          } else if (!state.isLoadingAIResult &&
              context.loaderOverlay.visible) {
            context.loaderOverlay.hide();
          }
          // show apiError toast
          if (state.aiError) {
            showErrorSnackBar(
              context,
              "An error occurred while fetching AI data",
            );
          } else if (state.aiSuccess) {
            setState(() {
              _nameController.text = state.item.name;
              _categoryController.text = state.item.category;
            });
          }
        },
        builder: (context, state) {
          return LoaderOverlay(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  context.read<CreateItemCubit>().state.isEditing
                      ? 'Edit Item'
                      : 'Register new Item',
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Gap(20),
                        TextFormField(
                          initialValue: state.item.epc,
                          decoration: InputDecoration(
                            hintText: "EPC",
                            errorText: state.epcError,
                            helperText: ' ',
                          ),
                          onChanged: (value) => context
                              .read<CreateItemCubit>()
                              .onEPCChanged(value),
                        ),
                        Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blueGrey[400],
                          ),
                          child: Image.file(
                            File(
                              state.item.image,
                            ),
                            errorBuilder: (context, error, stackTrace) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(12),
                                child: const SizedBox(
                                  height: 200,
                                  child: FittedBox(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _onImagePickerTapped(context);
                                },
                              );
                            },
                          ),
                        ),
                        Gap(20),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed:
                                  context.read<CreateItemCubit>().autoFill,
                              child: const Text("Autofill with AI"),
                            ),
                            const Expanded(
                              child: Text(
                                'This feature requires an active internet connection',
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            errorText: state.nameError,
                          ),
                          onChanged: (value) => context
                              .read<CreateItemCubit>()
                              .onNameChanged(value),
                        ),
                        TextFormField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            hintText: "Category",
                            errorText: state.categoryError,
                          ),
                          onChanged: (value) => context
                              .read<CreateItemCubit>()
                              .onCategoryChanged(value),
                        ),
                        Builder(
                          builder: (context) {
                            final tags = state.item.tags;
                            return TagEditor(
                              length: tags.length,
                              delimiters: const [',', ' '],
                              hasAddButton: false,
                              inputDecoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Hint Text...',
                                errorText: state.tagsError,
                              ),
                              onTagChanged: (tag) => context
                                  .read<CreateItemCubit>()
                                  .onTagAdded(tag),
                              tagBuilder: (context, index) => Chip(
                                label: Text(tags[index]),
                              ),
                            );
                          },
                        ),
                        ColorPicker(
                          title: const Text("Pick a color"),
                          enableShadesSelection: false,
                          pickersEnabled: const <ColorPickerType, bool>{
                            ColorPickerType.custom: true,
                            ColorPickerType.accent: false,
                            ColorPickerType.primary: false,
                          },
                          subheading: state.colorError != null
                              ? Text(
                                  state.colorError!,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : null,
                          customColorSwatchesAndNames:
                              context.read<CreateItemCubit>().colorToName,
                          color: context
                                  .read<CreateItemCubit>()
                                  .nameToColor[state.item.color] ??
                              const Color(0xFF000000),
                          onColorChanged: (color) =>
                              context.read<CreateItemCubit>().onColorChanged(
                                    context
                                        .read<CreateItemCubit>()
                                        .colorStringToName[color.toString()]!,
                                  ),
                        ),
                        DropdownMenu(
                          dropdownMenuEntries: menuEntries,
                          hintText: "Select an inventory",
                          onSelected: (value) => context
                              .read<CreateItemCubit>()
                              .onInventoryChanged(value),
                          errorText: state.inventoryError,
                          initialSelection: selectedEntry,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CreateItemCubit>().onSubmitItem();
                          },
                          child: const Text("Create"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String? _getSelectedEntry(
  BuildContext context,
  List<InventoryModel> allInventories,
  ItemModel? item,
) {
  if (item == null) {
    return null;
  }
  final previousInventoryId = allInventories
      .firstWhere(
        (element) => element.items
            .where((element) => element.epc == item.epc)
            .isNotEmpty,
      )
      .id;

  return previousInventoryId;
}

Future<void> _onImagePickerTapped(BuildContext context) async {
  final readerCubit = context.read<ReaderCubit>();

  var cameraStatus = await Permission.camera.status;

  if (cameraStatus.isPermanentlyDenied) {
    await openAppSettings();
    return;
  }

  if (!cameraStatus.isGranted) {
    await Permission.camera.request();
    cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      return;
    }
  }

  readerCubit.setHandledDisconnectFlag(true);
  final image = await ImagePicker().pickImage(
    source: ImageSource.camera,
    imageQuality: 20,
    requestFullMetadata: false,
  );
  if (readerCubit.state.status == ReaderStatus.disconnected) {
    await readerCubit.connect();
    readerCubit.setHandledDisconnectFlag(false);
  }
  if (image != null) {
    // save image using path provider
    final appDir = await getApplicationDocumentsDirectory();
    final imageFile = File('${appDir.path}/${const Uuid().v4()}.jpeg');
    await imageFile.writeAsBytes(await image.readAsBytes());
    context.read<CreateItemCubit>().onImageChanged(imageFile.path);
  }
}
