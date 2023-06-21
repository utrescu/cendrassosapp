import 'package:cendrassos/config_cendrassos.dart';
import 'package:flutter/material.dart';

class ErrorRetry extends StatelessWidget {
  final String errorType;
  final String errorMessage;
  final String textBoto;
  final VoidCallback onRetryPressed;

  const ErrorRetry(
      {Key? key,
      required this.errorType,
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
            child: Column(
              children: [
                Text(
                  errorType,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 22,
                ),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: onRetryPressed,
                child: const Text(
                  missatgeOk,
                )),
          ),
        ],
      ),
    );
  }
}

class ErrorRetryLogin extends StatelessWidget {
  final String errorMessage;
  final String errorType;
  final VoidCallback onRetryPressed;
  final VoidCallback onLogin;

  const ErrorRetryLogin(
      {Key? key,
      required this.errorType,
      required this.errorMessage,
      required this.onRetryPressed,
      required this.onLogin})
      : super(key: key);

  Widget _boto(context, String text, VoidCallback metode) {
    return ElevatedButton(
      onPressed: metode,
      child: Text(
        text,
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
            child: Column(
              children: [
                Text(
                  errorType,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
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
