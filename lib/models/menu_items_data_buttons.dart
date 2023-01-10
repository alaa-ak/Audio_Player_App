import 'package:flutter/material.dart';
import 'package:music_player_app/models/menu_item_buttons.dart';

class MenuItemsDataButtons {
  static const List<MenuItemButtons> itemList = [
    MenuItemButtons(text: 'Delete', icon: Icons.delete),
    MenuItemButtons(text: 'Rename', icon: Icons.edit),
    MenuItemButtons(text: 'Share', icon: Icons.share),
  ];

  //  itemDelete,
  //   itemRename,
  //   itemShare,
  // static const MenuItemButtons itemDelete =
  //     const MenuItemButtons(text: 'Delete', icon: Icons.delete);

  // static const MenuItemButtons itemRename =
  //     const MenuItemButtons(text: 'Rename', icon: Icons.edit);

  // static const MenuItemButtons itemShare =
  //     const MenuItemButtons(text: 'Share', icon: Icons.share);
}
