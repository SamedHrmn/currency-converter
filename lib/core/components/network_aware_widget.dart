import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../services/network_status_service.dart';

class NetworkAwareWidget extends StatelessWidget {
  final Widget onlineChild;
  final Widget offlineChild;

  const NetworkAwareWidget({Key? key, required this.onlineChild, required this.offlineChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var networkStatus = Provider.of<NetworkStatus>(context);
    print(networkStatus);
    if (networkStatus == NetworkStatus.Online) {
      return onlineChild;
    } else if (networkStatus == NetworkStatus.Offline) {
      _showToastMessage('No Internet Connection , Please restart the app.');
    }
    return offlineChild;
  }

  void _showToastMessage(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1);
  }
}
