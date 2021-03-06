import 'package:camera/camera.dart';
import 'package:face_app/screens/face_scanner_screen.dart';
import 'package:face_app/widgets/app_drawer.dart';
import 'package:face_app/screens/qr_scanner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height) *
                  0.9,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(
                  child: Text('Map'),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            'Aqua Tech Inc, Suite No. 57, Tower C2 Aqua Business Park',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Punch In',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text('-- : --')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Punch Out',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text('-- : --')
                            ],
                          ),
                        ],
                      ),
                      // Stack(
                      //   children: [
                      //     Container(
                      //       height: 70,
                      //       width: double.infinity,
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: Theme.of(context).primaryColor,
                      //       ),
                      //       child: InkWell(
                      //         onTap: () async {
                      //           final cameras = await availableCameras();

                      //           // Get a specific camera from the list of available cameras.
                      //           final firstCamera = cameras.last;

                      //           Navigator.of(context).pushNamed(
                      //               FaceScanner.routeName,
                      //               arguments: firstCamera);
                      //         },
                      //         child: Container(
                      //           // width: MediaQuery.of(context).size.width * 0.6,
                      //           alignment: Alignment.center,
                      //           padding: EdgeInsets.only(left: 20),
                      //           child: Text(
                      //             'Tap to Scan',
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 22),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 80,
                            child: RaisedButton(
                              onPressed: () async {
                                final cameras = await availableCameras();

                                // Get a specific camera from the list of available cameras.
                                final firstCamera = cameras.last;

                                Navigator.of(context).pushNamed(
                                    FaceScanner.routeName,
                                    arguments: firstCamera);
                              },
                              // color: Colors.amber[200],
                              // textColor: Colors.white,
                              child: Text(
                                'Scan Face',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 80,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(QRScanner.routeName);
                              },
                              // color: Colors.amber[200],
                              // textColor: Colors.white,
                              child: Text(
                                'Scan QR',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
