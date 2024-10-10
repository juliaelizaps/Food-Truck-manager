import 'package:flutter/material.dart';

class RedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  RedButton({required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // Cor de fundo rosa
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}/* Nao coloquei pra rodar, oq esse inicia sem o Total selecionado, mas funciona
class MyFilterChip extends StatefulWidget {
  final String label;

  const MyFilterChip({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  _MyFilterChipState createState() => _MyFilterChipState();
}

class _MyFilterChipState extends State<MyFilterChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      backgroundColor: _isSelected ? Colors.green[100] : Colors.grey,
      selectedColor: Colors.green[100],
    );
  }
}
*/


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
          if (widget.icon != null) SizedBox(width: 4),
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
