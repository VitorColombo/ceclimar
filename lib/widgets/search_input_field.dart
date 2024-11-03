import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

class SearchInputField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function? onChanged;
  final int? maxLines;
  final List<String> items;

  const SearchInputField({
    super.key,
    required this.text,
    required this.controller,
    required this.items,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  List<String> _filteredItems = [];
  bool _isDropdownOpen = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _isDropdownOpen = true;
        });
      } else {
        setState(() {
          _isDropdownOpen = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _isDropdownOpen = true;
      _filteredItems = widget.items
        .where((item) =>
            _formatString(item).toLowerCase().contains(_formatString(query)) && item.isNotEmpty)
        .toList();
      if(_filteredItems.isEmpty){
        _filteredItems.add("Nenhum item encontrado");
      }
    });
  }

  String _formatString(String input){
    return removeDiacritics(input).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: TextInputType.text,
          cursorColor: Colors.grey,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xF6F6F6F6),
            labelText: widget.text,
            labelStyle: Theme.of(context).textTheme.labelLarge,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlue,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            floatingLabelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.6,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.6,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorText: widget.validator != null
                ? widget.validator!(widget.controller.text)
                : null,
            errorStyle: const TextStyle(
              fontSize: 12,
              height: 0.5,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          ),
          onChanged: (value) {
            _filterItems(value.trim());
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
        if (_isDropdownOpen && _filteredItems.isNotEmpty)
          Container(
            constraints: BoxConstraints(
              maxHeight: 300, 
            ),
            decoration: BoxDecoration(
              color: const Color(0xF6F6F6F6),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0),
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredItems[index]),
                  onTap: () {
                    widget.controller.text = _filteredItems[index];
                    _filterItems(_filteredItems[index]);
                    _focusNode.requestFocus();
                      setState(() {
                      _isDropdownOpen = false;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(widget.controller.text);
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}