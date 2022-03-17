import 'package:cendrassos/cendrassos_theme.dart';
import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final String errorMessage;
  final String textBoto;
  final VoidCallback onRetryPressed;

  const ErrorRetry(
      {Key? key,
      required this.errorMessage,
      required this.textBoto,
      required this.onRetryPressed})
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
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            child: Text(textBoto,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.background,
                )),
            style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).colorScheme.background,
                primary: Theme.of(context).colorScheme.primary,
                onSurface: Colors.white),
            onPressed: onRetryPressed,
          ),
        ],
      ),
    );
  }
}

class ErrorRetryLogin extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;
  final VoidCallback onLogin;

  const ErrorRetryLogin(
      {Key? key,
      required this.errorMessage,
      required this.onRetryPressed,
      required this.onLogin})
      : super(key: key);

  Widget _boto(context, String text, VoidCallback metode) {
    return ElevatedButton(
      child: Text(text,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.background,
          )),
      style: ElevatedButton.styleFrom(
          onPrimary: Theme.of(context).colorScheme.background,
          primary: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: titleFontSize,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: [
              _boto(context, 'Torna-ho a provar', onRetryPressed),
              _boto(context, 'Entrar credencials de nou', onLogin),
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
              color: Theme.of(context).colorScheme.primary,
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
