import 'package:cendrassos/config_cendrassos.dart';
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
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              disabledForegroundColor: Colors.white.withOpacity(0.38),
              disabledBackgroundColor: Colors.white.withOpacity(0.12),
            ),
            onPressed: onRetryPressed,
            child: Text(
              textBoto,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
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
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.primary,
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
      ),
      onPressed: metode,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).colorScheme.secondary,
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
              _boto(context, missatgeTornaAProvar, onRetryPressed),
              _boto(context, missatgeTornaALogin, onLogin),
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
