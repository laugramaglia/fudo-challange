import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool isPass;
  final List<TextInputValidators> validators;
  final Function(String?)? onError;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.icon,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.isPass = false,
    this.validators = const [],
    this.onError,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  String? error;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: _onChange,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            controller: widget.controller,
            obscureText: widget.isPass,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              hintText: widget.hintText,
              border: InputBorder.none,
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
          if (error case final error?)
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 4),
              child: Text(
                error,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            )
        ],
      );

  _onChange(String value) {
    if (widget.validators.isEmpty) return;
    error = [
      for (final validator in widget.validators)
        error = switch (validator) {
          TextInputValidators.required => value.isEmpty ? 'Required' : null,
          TextInputValidators.email => value.isNotEmpty &&
                  !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)
              ? 'Invalid email'
              : null,
          TextInputValidators.number =>
            value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
                ? 'Invalid number'
                : null,
        }
    ].where((e) => e != null).join(', ');

    if (widget.onError != null) {
      widget.onError?.call("${widget.hintText}: $error");
    }

    setState(() {});
  }
}

enum TextInputValidators { required, email, number }
