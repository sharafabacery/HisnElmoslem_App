import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisnelmoslem/shared/constants/constant.dart';

class UserNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChange;

  const UserNumberField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          // autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: onChange,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black45,
            border: InputBorder.none,
            // focusedBorder: InputBorder.none,

            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 5, top: 5, right: 15),
          )),
    );
  }
}
