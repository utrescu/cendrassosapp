import 'package:cendrassos/cendrassos_theme.dart';
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;

  const Error(
      {Key? key, required this.errorMessage, required this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            child: Flexible(
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: titleFontSize,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            child: Text('Torna-ho a provar',
                style: TextStyle(fontSize: 20, color: secondaryColor)),
            style: ElevatedButton.styleFrom(
                onPrimary: secondaryColor,
                primary: primaryColor,
                onSurface: Colors.grey),
            onPressed: onRetryPressed,
          ),
        ],
      ),
    );
  }
}

class Error2Buttons extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;
  final VoidCallback onLogin;

  const Error2Buttons(
      {Key? key,
      required this.errorMessage,
      required this.onRetryPressed,
      required this.onLogin})
      : super(key: key);

  Widget _boto(String text, VoidCallback metode) {
    return ElevatedButton(
      child: Text(text, style: TextStyle(fontSize: 20, color: secondaryColor)),
      style: ElevatedButton.styleFrom(
          onPrimary: secondaryColor,
          primary: primaryColor,
          onSurface: Colors.grey),
      onPressed: metode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            child: Flexible(
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: titleFontSize,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: [
              _boto('Torna-ho a provar', onRetryPressed),
              _boto('Entrar credencials de nou', onLogin),
            ],
          ),
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key? key, required this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontSize: titleFontSize,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColorLight),
          ),
        ],
      ),
    );
  }
}