import 'package:flutter/material.dart';

class CupItem extends StatelessWidget {
  final String cupName;
  final IconData cupIcon;
  final int cupSize;
  final bool chosen;
  const CupItem({
    super.key,
    required this.cupName,
    required this.cupIcon,
    required this.cupSize,
    required this.chosen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: chosen ? Colors.blue : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              blurRadius: chosen ? 15 : 0,
              offset: chosen ? const Offset(10, 10) : const Offset(0, 0),
              color: chosen ? Colors.black.withOpacity(0.5) : Colors.black)
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            cupName,
            style: TextStyle(
              color: chosen ? Colors.white : Colors.black,
            ),
          ),
          Icon(
            cupIcon,
            color: chosen ? Colors.white : Colors.black,
          ),
          Text(
            "${cupSize}ml",
            style: TextStyle(
              color: chosen ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
