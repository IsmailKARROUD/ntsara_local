import 'package:flutter/material.dart';

class ProviderSignInButton extends StatefulWidget {
  ProviderSignInButton({
    required this.tTS,
    required this.image,
    required this.title,
    required,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.imageHigh = 35,
  });
  Future<void> Function() tTS;
  ImageProvider<Object> image;
  String title;
  Color color;
  Color textColor;
  double imageHigh;
  @override
  _ProviderSignInButtonState createState() => _ProviderSignInButtonState();
}

class _ProviderSignInButtonState extends State<ProviderSignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          await widget.tTS();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: widget.image,
                height: widget.imageHigh,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: widget.textColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
