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
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Theme.of(context).colorScheme.background,
              primary: Theme.of(context).colorScheme.primary,
              onSurface: Colors.white,
            ),
            onPressed: onRetryPressed,
            child: Text(
              textBoto,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontSize: 20,
              ),
            ),
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
      style: ElevatedButton.styleFrom(
        onPrimary: Theme.of(context).colorScheme.background,
        primary: Theme.of(context).colorScheme.primary,
        onSurface: Colors.grey,
      ),
      onPressed: metode,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
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
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 12),
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColorLight),
          ),
        ],
      ),
    );
  }
}
