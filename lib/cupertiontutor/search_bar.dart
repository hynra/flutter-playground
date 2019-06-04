import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/cupertiontutor/styles.dart';

class SearchBar extends StatelessWidget {

  final TextEditingController controller;
  final FocusNode focusNode;

  const SearchBar({@required this.controller, @required this.focusNode});


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: this.controller,
                focusNode: this.focusNode,
                style: Styles.deliveryTimeLabel,
                cursorColor: Styles.searchCursorColor,
              ),
            ),
            GestureDetector(
              onTap: this.controller.clear,
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
