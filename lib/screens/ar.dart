// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class AR extends StatefulWidget {

//   @override
//   _ARState createState() => _ARState();
// }

// class _ARState extends State<AR> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Theme.of(context)
//             .primaryColor,
//         body: InAppWebView(
//             initialUrlRequest: URLRequest(url: Uri.parse("https://soupaul.github.io/aarohanAR/")),
//             initialOptions:
//             InAppWebViewGroupOptions(
//               crossPlatform:
//               InAppWebViewOptions(
//                 mediaPlaybackRequiresUserGesture:
//                 false,
//               ),
//             ),
//             onWebViewCreated:
//                 (InAppWebViewController
//             controller) {
//             },
//             androidOnPermissionRequest: (controller, origin, resources) async {
//               return PermissionRequestResponse(
//                   resources: resources,
//                   action: PermissionRequestResponseAction.GRANT);
//             }

//             ),
//       ),
//     );
//   }
// }
