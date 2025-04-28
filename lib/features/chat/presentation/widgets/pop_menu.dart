import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

enum MenuAction {
  viewContact,
  search,
  addToList,
  media,
  disappearing,
  mute,
  report,
  block,
  clearChat,
  exportChat,
}

class AppPopupMenu extends StatelessWidget {
  final Function(MenuAction) onSelected;

  const AppPopupMenu({super.key, required this.onSelected});

  void _showSubMenu(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu<MenuAction>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + size.width,
        offset.dy * 2.22,
        MediaQuery.of(context).size.width - (offset.dx + size.width),
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: _buildSubMenuItems(),
    ).then((value) {
      if (value != null) onSelected(value);
    });
  }

  List<PopupMenuEntry<MenuAction>> _buildMainMenuItems(BuildContext context) {
    return [
      _menuItem(title: "View contact", value: MenuAction.viewContact),
      _menuItem(title: "Search", value: MenuAction.search),
      _menuItem(title: "Add to list", value: MenuAction.addToList),
      _menuItem(title: "Media, links, and docs", value: MenuAction.media),
      _menuItem(title: "Disappearing messages", value: MenuAction.disappearing),
      _menuItem(title: "Mute notifications", value: MenuAction.mute),
      PopupMenuItem<MenuAction>(
        onTap: () => _showSubMenu(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("More"),
            Icon(Icons.arrow_right, size: 20, color: context.onSurface),
          ],
        ),
      ),
    ];
  }

  List<PopupMenuEntry<MenuAction>> _buildSubMenuItems() {
    return [
      _menuItem(title: "Report", value: MenuAction.report),
      _menuItem(title: "Block", value: MenuAction.block),
      _menuItem(title: "Clear chat", value: MenuAction.clearChat),
      _menuItem(title: "Export Chat", value: MenuAction.exportChat),
    ];
  }

  PopupMenuItem<MenuAction> _menuItem({
    required String title,
    required MenuAction value,
  }) {
    return PopupMenuItem<MenuAction>(value: value, child: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      popUpAnimationStyle: AnimationStyle(
        duration: Duration(milliseconds: 400),
        curve: Curves.bounceInOut,
        reverseCurve: Curves.bounceInOut,
        reverseDuration: Duration(milliseconds: 400),
      ),
      position: PopupMenuPosition.under,
      onSelected: onSelected,
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => _buildMainMenuItems(context),
    );
  }
}
