// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:rfid_inventory_app/core/models/inventory_model.dart' as _i8;
import 'package:rfid_inventory_app/core/models/item_model.dart' as _i10;
import 'package:rfid_inventory_app/core/models/rfid_model.dart' as _i11;
import 'package:rfid_inventory_app/features/connect/presentation/connect_page.dart'
    as _i1;
import 'package:rfid_inventory_app/features/create_inventory/presentation/create_inventory_page.dart'
    as _i2;
import 'package:rfid_inventory_app/features/create_item/presentation/create_item_page.dart'
    as _i3;
import 'package:rfid_inventory_app/features/home/presentation/home_page.dart'
    as _i4;
import 'package:rfid_inventory_app/features/inventory/presentation/inventory_page.dart'
    as _i5;
import 'package:rfid_inventory_app/features/settings/presentation/settings_page.dart'
    as _i6;

/// generated route for
/// [_i1.ConnectPage]
class ConnectRoute extends _i7.PageRouteInfo<void> {
  const ConnectRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ConnectRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConnectRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConnectPage();
    },
  );
}

/// generated route for
/// [_i2.CreateInventoryPage]
class CreateInventoryRoute extends _i7.PageRouteInfo<CreateInventoryRouteArgs> {
  CreateInventoryRoute({
    _i8.InventoryModel? inventory,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          CreateInventoryRoute.name,
          args: CreateInventoryRouteArgs(
            inventory: inventory,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateInventoryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateInventoryRouteArgs>(
          orElse: () => const CreateInventoryRouteArgs());
      return _i2.CreateInventoryPage(
        inventory: args.inventory,
        key: args.key,
      );
    },
  );
}

class CreateInventoryRouteArgs {
  const CreateInventoryRouteArgs({
    this.inventory,
    this.key,
  });

  final _i8.InventoryModel? inventory;

  final _i9.Key? key;

  @override
  String toString() {
    return 'CreateInventoryRouteArgs{inventory: $inventory, key: $key}';
  }
}

/// generated route for
/// [_i3.CreateItemPage]
class CreateItemRoute extends _i7.PageRouteInfo<CreateItemRouteArgs> {
  CreateItemRoute({
    _i10.ItemModel? item,
    _i11.RFIDModel? rfidModel,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          CreateItemRoute.name,
          args: CreateItemRouteArgs(
            item: item,
            rfidModel: rfidModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateItemRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateItemRouteArgs>(
          orElse: () => const CreateItemRouteArgs());
      return _i3.CreateItemPage(
        item: args.item,
        rfidModel: args.rfidModel,
        key: args.key,
      );
    },
  );
}

class CreateItemRouteArgs {
  const CreateItemRouteArgs({
    this.item,
    this.rfidModel,
    this.key,
  });

  final _i10.ItemModel? item;

  final _i11.RFIDModel? rfidModel;

  final _i9.Key? key;

  @override
  String toString() {
    return 'CreateItemRouteArgs{item: $item, rfidModel: $rfidModel, key: $key}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.InventoryPage]
class InventoryRoute extends _i7.PageRouteInfo<InventoryRouteArgs> {
  InventoryRoute({
    required String inventoryId,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          InventoryRoute.name,
          args: InventoryRouteArgs(
            inventoryId: inventoryId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InventoryRouteArgs>();
      return _i5.InventoryPage(
        inventoryId: args.inventoryId,
        key: args.key,
      );
    },
  );
}

class InventoryRouteArgs {
  const InventoryRouteArgs({
    required this.inventoryId,
    this.key,
  });

  final String inventoryId;

  final _i9.Key? key;

  @override
  String toString() {
    return 'InventoryRouteArgs{inventoryId: $inventoryId, key: $key}';
  }
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsPage();
    },
  );
}
