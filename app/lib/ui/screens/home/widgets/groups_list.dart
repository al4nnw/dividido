import 'package:dividido/ui/widgets/card_tile.dart';
import 'package:flutter/material.dart';

class GroupsList extends StatefulWidget {
  const GroupsList({super.key});

  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 100,
      itemBuilder: (context, index) {
        return CardTile(
          key: ValueKey(index),
          title: "Festa do juca",
          subtitle: "Criado em 12/12/2021 por João Fraife",
          showUnderline: true,
          addPadding: true,
        );
      },
    );
  }
}
