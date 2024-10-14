import 'package:flutter/material.dart';

class MyFilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Color? selectedColor;
  final Color? backgroundColor;
  final IconData? icon;
  final ShapeBorder? shape;

  const MyFilterChip({
    required this.label,
    this.isSelected = false,
    this.selectedColor,
    this.backgroundColor,
    this.icon,
    this.shape,
    Key? key,
  }) : super(key: key);

  @override
  _MyFilterChipState createState() => _MyFilterChipState();
}

class _MyFilterChipState extends State<MyFilterChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) Icon(widget.icon, size: 18),
          if (widget.icon != null) const SizedBox(width: 4),
          Text(widget.label),
        ],
      ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      backgroundColor: _isSelected
          ? widget.selectedColor ?? Colors.greenAccent[100]
          : widget.backgroundColor ?? Colors.blue[50],
      selectedColor: widget.selectedColor ?? Colors.greenAccent[100],
    );
  }
}
