import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

class SearchInputField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function? onChanged;
  final int? maxLines;
  final List<String> items;
  final FocusNode focusNode;
  final Function? onFocusUpdate; 

  const SearchInputField({
    super.key,
    required this.text,
    required this.controller,
    required this.items,
    required this.focusNode,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.onFocusUpdate,
  });

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  List<String> _filteredItems = [];
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        if (widget.onFocusUpdate != null) {
          widget.onFocusUpdate!();
        }
        _filterItems(widget.controller.text);
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
        _filteredItems.add("Outro");
      }
    });
  }

  String _formatString(String input){
    return removeDiacritics(input).toLowerCase();
  }

  void _closeDropdown() {
    setState(() {
      _isDropdownOpen = false;
    });
  }

  Future<bool> _onWillPop() async {
    if (_isDropdownOpen) {
      _closeDropdown();
      widget.focusNode.unfocus();
      return false; 
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              focusNode: widget.focusNode,
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
                widget.onChanged!(value);
              },
            ),
            Visibility(
              visible: widget.validator != null && widget.validator!(widget.controller.text) != null,
              child: SizedBox(height: 5)
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
                        widget.focusNode.requestFocus();
                        widget.controller.text = _filteredItems[index];
                        widget.focusNode.unfocus();
                          setState(() {
                          _isDropdownOpen = false;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.controller.text);
                          widget.onFocusUpdate!();
                        }
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}