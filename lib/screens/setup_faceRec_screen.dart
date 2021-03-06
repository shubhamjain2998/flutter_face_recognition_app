import 'package:face_app/models/app_exception.dart';
import 'package:face_app/providers/attendance.dart';
import 'package:face_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class SetupFaceRecScreen extends StatefulWidget {
  static const routeName = '/setup-faceRecognition';
  @override
  _SetupFaceRecScreenState createState() => _SetupFaceRecScreenState();
}

class _SetupFaceRecScreenState extends State<SetupFaceRecScreen> {
  List<Asset> images = List<Asset>();
  String _error;
  var _loading = false;

  String _submitTitle = 'Submitted';
  String _submitErrorTitle = 'An Error Occurred!';
  String _submitContent =
      'Your data has been saved successfully and ready to use.';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    if (images != null)
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(images.length, (index) {
            Asset asset = images[index];
            return Stack(
              overflow: Overflow.visible,
              children: [
                Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                    child: CircleAvatar(
                      maxRadius: 15,
                      child: Icon(
                        Icons.close,
                        size: 20,
                      ),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 50,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  void _showErrorDialog(String title, String message, bool error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void submitData() async {
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Attendance>(context, listen: false)
          .trainDataset(images);
      _showErrorDialog(_submitTitle, _submitContent, false);
    } on AppException catch (error) {
      _showErrorDialog(_submitErrorTitle, error.toString(), true);
    } catch (error) {
      _showErrorDialog(_submitErrorTitle, error.toString(), true);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   icon: Icon(Icons.arrow_back),
        // ),
        title: Text('Upload Your Images'),
      ),
      // drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        heroTag: 'addPhotosButton',
        onPressed: loadAssets,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_a_photo),
      ),
      body: Column(
        children: <Widget>[
          if (_error != 'No Error Dectected' && _error != null)
            Center(child: Text('Error: $_error')),
          if (images == null || images.length == 0)
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    "You have not selected any image. Please select images.",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          Expanded(
            child: buildGridView(),
          ),
          if (images != null && images.length != 0)
            Container(
              padding: EdgeInsets.only(bottom: 20),
              height: 70,
              width: 150,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: submitData,
                child: _loading
                    ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ))
                    : Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
              ),
            )
        ],
      ),
    );
  }
}
