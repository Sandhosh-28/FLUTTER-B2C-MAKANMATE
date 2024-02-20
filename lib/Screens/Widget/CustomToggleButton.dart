import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  final bool value;
  final Function(bool) onTap;

  CustomToggleButton({
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(!value);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3, left: 2),
            child: Container(
              height: 30,
              width: 55,
              decoration: BoxDecoration(
                color: value ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(),
              ),
            ),
          ),
          Padding(
            padding: value
                ? const EdgeInsets.only(left: 24)
                : const EdgeInsets.only(left: 0),
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(),
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),

      // Container(
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     color: value ? Colors.green : Colors.red,
      //   ),
      //   width: 50,
      //   height: 50,
      //   child: Center(
      //     child: Text(
      //       value ? 'On' : 'Off',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
    );
  }
}
