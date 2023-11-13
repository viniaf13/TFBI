import 'package:flutter/material.dart';

///CustomBottomSheet
/// Used for unique drag functionality and utility upon sheet presenting/closing
class CustomBottomSheet {
  static void presentBottomSheet({
    required BuildContext context,
    required String sheetTitle, //title top center of sheet
    required List<Widget> sheetList, //list which wont interfere with expand
    Function()? onOpen, //what occurs on presenting
    Function()? whenComplete, //what occurs when closing
  }) {
    if (onOpen != null) {
      onOpen();
    }

    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 15,
      shape: const RoundedRectangleBorder(
        //Adapt for usage
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => CustomBottomSheetWidget(
        sheetTitle: sheetTitle,
        sheetList: sheetList,
      ),
    ).whenComplete(
      (whenComplete != null) ? whenComplete : () {},
    );
  }
}

class CustomBottomSheetWidget extends StatelessWidget {
  const CustomBottomSheetWidget({
    Key? key,
    required this.sheetTitle,
    required this.sheetList,
  }) : super(key: key);

  final String sheetTitle;
  final List<Widget> sheetList;

  @override
  Widget build(BuildContext context) {
    //Our method of achieving expand on drag
    return DraggableScrollableSheet(
      minChildSize: .5,
      maxChildSize: .9,
      initialChildSize: .5,
      snap: false,
      expand: false,
      builder: (_, ScrollController scrollController2) => Column(
        children: [
          //Our draggable area on which we are able to expand
          //wrapped around the header to avoid scroll conflicts with list
          SingleChildScrollView(
            controller: scrollController2,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Stack(
                children: [
                  Center(
                    child: TextButton(
                      onPressed: null,
                      child: Text(
                        sheetTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(color: Colors.grey.shade300, height: .75),
          Expanded(
            child: ListView(
              semanticChildCount: sheetList.length,
              children: sheetList,
            ),
          ),
        ],
      ),
    );
  }
}
