import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rfid_inventory_app/core/models/inventory_model.dart';
import 'package:rfid_inventory_app/features/create_inventory/cubits/create_inventory_cubit.dart';
import 'package:rfid_inventory_app/features/home/cubits/inventories_cubit.dart';

@RoutePage()
class CreateInventoryPage extends StatelessWidget {
  const CreateInventoryPage({
    this.inventory,
    super.key,
  });

  final InventoryModel? inventory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateInventoryCubit(
        inventory: inventory ?? InventoryModel.empty(),
        isEditing: inventory != null,
      ),
      child: BlocListener<CreateInventoryCubit, CreateInventoryState>(
        listener: (context, state) {
          if (state.success) {
            context.router.maybePop();
            context.read<InventoriesCubit>().loadInventories();
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  _isEditing(context) ? 'Edit Inventory' : 'Create Inventory',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                centerTitle: false,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Gap(20),
                        TextFormField(
                          initialValue: _nameValue(context),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            errorText: _nameError(context),
                            helperText: ' ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) => _onNameChanged(context, value),
                        ),
                        TextFormField(
                          initialValue: _descriptionValue(context),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            errorText: _descriptionError(context),
                            helperText: ' ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) =>
                              _onDescriptionChanged(context, value),
                        ),
                        TextFormField(
                          initialValue: _locationValue(context),
                          decoration: InputDecoration(
                            labelText: 'Location',
                            errorText: _locationError(context),
                            helperText: ' ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) =>
                              _onLocationChanged(context, value),
                        ),
                        TextFormField(
                          minLines: 6,
                          maxLines: 6,
                          initialValue: _noteValue(context),
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Notes',
                            errorText: _noteError(context),
                            helperText: ' ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) => _onNoteChanged(context, value),
                        ),
                        FilledButton(
                          onPressed: () => _onSubmitPressed(context),
                          child: Text(
                            _isEditing(context) ? 'Save' : 'Create',
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Getters
  String? _nameValue(BuildContext context) =>
      context.read<CreateInventoryCubit>().state.inventory.name;

  String? _descriptionValue(BuildContext context) =>
      context.read<CreateInventoryCubit>().state.inventory.description;

  String? _locationValue(BuildContext context) =>
      context.read<CreateInventoryCubit>().state.inventory.location;

  String? _noteValue(BuildContext context) =>
      context.read<CreateInventoryCubit>().state.inventory.note;

  bool _isEditing(BuildContext context) =>
      context.read<CreateInventoryCubit>().state.isEditing;

  // Listen
  String? _nameError(BuildContext context) =>
      context.watch<CreateInventoryCubit>().state.nameError;

  String? _descriptionError(BuildContext context) =>
      context.watch<CreateInventoryCubit>().state.descriptionError;

  String? _locationError(BuildContext context) =>
      context.watch<CreateInventoryCubit>().state.locationError;

  String? _noteError(BuildContext context) =>
      context.watch<CreateInventoryCubit>().state.noteError;

  // Events
  void _onNameChanged(BuildContext context, String value) =>
      context.read<CreateInventoryCubit>().onNameChanged(value);

  void _onDescriptionChanged(BuildContext context, String value) =>
      context.read<CreateInventoryCubit>().onDescriptionChanged(value);

  void _onLocationChanged(BuildContext context, String value) =>
      context.read<CreateInventoryCubit>().onLocationChanged(value);

  void _onNoteChanged(BuildContext context, String value) =>
      context.read<CreateInventoryCubit>().onNoteChanged(value);

  void _onSubmitPressed(BuildContext context) {
    context.read<CreateInventoryCubit>().onSubmitInventory();
  }
}
