import 'dart:convert';

import 'package:cendrassos/config_cendrassos.dart';
import 'package:cendrassos/models/qr.dart';
import 'package:cendrassos/providers/djau.dart';
import 'package:cendrassos/screens/components/scanner_control.dart';
import 'package:cendrassos/screens/scanqr_page.dart';
import 'package:cendrassos/screens/users_page.dart';
import 'package:cendrassos/utils/global_navigator.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Qr _qrKey =  Qr.empty();
  final _formkey = GlobalKey<FormState>();
  final _dateinputController = TextEditingController();

  bool _isSendButtonDisabled = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateinputController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   _dateinputController.text = ""; //set the initial value of text field
  //   _isScanButtonDisabled = false;
  //   _isSendButtonDisabled = true;
  //   super.initState();
  // }

  Future<LoginResult> _getUsername(BuildContext context) async {
    var registerCall = context.read<DjauModel>();

    var result = await registerCall.register(_qrKey, _dateinputController.text);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: 5,
              ),
              children: [
                SizedBox(height: height * 0.20),
                Center(
                  child: SizedBox(
                    width: width * 0.6,
                    child: Image.asset('assets/images/logo_cendrassos.png'),
                  ),
                ),
                SizedBox(height: height * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: height * 0.05,
                    vertical: 0.025,
                  ),
                  child: ScannerControl(
                    qrkey: _qrKey,
                    height: height*0.02,
                    width: width*0.02,
                    scan: _scanQr,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: height * 0.05,
                    vertical: width * 0.05,
                  ),
                  child: TextFormField(
                    controller: _dateinputController,
                    readOnly: true,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      labelText: etiquetaDataNaixement,
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      hintText: etiquetaDataNaixement,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              1980), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        setState(() {
                          _dateinputController.text =
                              formattedDate; //set output date to TextField value.
                          _isSendButtonDisabled = !_qrKey.isValid();
                        });
                      } else {
                        // log("Date is not selected");
                      }
                    },
                  ),
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.05,
                    vertical: width * 0.05,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: height * 0.05,
                        vertical: width * 0.05,
                      ),
                    ),
                    onPressed: _isSendButtonDisabled
                        ? null
                        : () async {
                            var x = await _getUsername(context);
                            if (mounted) {
                              gotoUsers(x, context);
                            }
                          },
                    child: const Text(etiquetaEnviarQR),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _scanQr() async {
    final data = await GlobalNavigator.go(ScanqrPage.routeName);
    // if (!mounted) return;
    var newqr = Qr.empty();

    try {
      var result = json.decode(data);
        newqr = Qr.fromJson(result);
        setState(() {
          _qrKey = newqr;
          _isSendButtonDisabled =
              !_qrKey.isValid() || _dateinputController.text.isEmpty;
        });
    } catch(e) {
      GlobalNavigator.showAlertPopup("ERROR", errorQR);
    }

  }

  void gotoUsers(LoginResult x, BuildContext context) {
    if (x.isLogged == DjauStatus.disabled) {
      GlobalNavigator.forgetAndGo(UsersPage.routeName);
    } else {
      GlobalNavigator.showAlertPopup(
        "ERROR",
        x.errorMessage,
      );
    }
  }
}
