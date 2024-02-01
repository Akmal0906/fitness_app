import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/utils/all_colors.dart';
import 'package:flutter/material.dart';

import '../../domain/textfield_model.dart';
import '../../utils/constants.dart';

class MyTextFieldWidget extends StatefulWidget {
  final TextFieldModel model;
  final String text;
  final int maxLine;

  const MyTextFieldWidget({super.key, required this.model, required this.text,this.maxLine=1});

  @override
  State<MyTextFieldWidget> createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<MyTextFieldWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text.tr(),
            style:
                customStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 12),
          ),
          TextField(

            maxLines: widget.maxLine,
            expands: false,
            controller: widget.model.controller,
            obscureText: widget.model.obscureText,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AllColors.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: widget.model.hintText.tr(),
                hintStyle: customStyle,
                suffixIcon: IconButton(
                  icon: widget.model.isNeed
                      ? Icon(
                          widget.model.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        )
                      : const SizedBox.shrink(),
                  onPressed: () {
                    setState(() {
                      widget.model.obscureText = !widget.model.obscureText;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );
  }
}
