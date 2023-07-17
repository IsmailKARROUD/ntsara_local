import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ntsara_local/assets/Mycolors.dart';

class OptionPopUp {
  String title;
  VoidCallback? onPressed;
  OptionPopUp(this.title, this.onPressed);
}

Future<void> popUPScreen(
    BuildContext context, String title, List<OptionPopUp> listOfOptionPopUp) {
  final mQSize = MediaQuery.of(context).size;

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    constraints: BoxConstraints(maxWidth: mQSize.width * 0.85),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          shadowColor: Colors.transparent,
          color: CupertinoColors.systemGrey6.withOpacity(0.95),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
            mQSize.width * 0.04,
          ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: myBlack.withOpacity(0.95),
                  ),
                ),
              )),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.zero,
                itemCount: listOfOptionPopUp.length,
                itemBuilder: (context, index) => TextButton(
                  child: Text(
                    listOfOptionPopUp[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onPressed: listOfOptionPopUp[index].onPressed,
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              TextButton(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: myRed,
                      ),
                    )),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      );
    },
  );
}
