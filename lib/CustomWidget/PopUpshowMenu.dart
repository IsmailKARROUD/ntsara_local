import 'package:flutter/material.dart';

class PopUpshowMenu extends StatelessWidget {
  final List<PopupMenuEntry> menuListShow;
  final Widget childShow;
  final Function(dynamic) onSelectedShow;
  const PopUpshowMenu(
      {Key? key,
      required this.menuListShow,
      required this.childShow,
      required this.onSelectedShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      position: PopupMenuPosition.under,
      itemBuilder: ((context) => menuListShow),
      child: childShow,
      onSelected: onSelectedShow,
    );
  }
}
