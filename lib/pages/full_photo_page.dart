import 'package:flutter/material.dart';
import 'package:chatterly/constants/app_constants.dart';
import 'package:chatterly/constants/color_constants.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  const FullPhotoPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: ColorConstants.primaryColor,
        iconTheme: IconThemeData(color: ColorConstants.white),
        title: Text(
          AppConstants.fullPhotoTitle,
          style: TextStyle(color: ColorConstants.white),
        ),
        //centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
