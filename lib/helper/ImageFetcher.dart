import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/configurations/assets.dart';
import '../core/configurations/styles.dart';

class ImageFetcher {
  static Widget getImage(url,
      {BoxFit fit = BoxFit.scaleDown,
      Duration fadeInDuration = const Duration(milliseconds: 500)}) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      alignment: Alignment.center,

      errorWidget: (context, url, error) => Align(
        alignment: Alignment.center,
        //child: SizedBox(
          //height: 40,
         // width: 40,
          child: Image.asset(
            Assets.PNG_SplashImage,
            // size: 40,
            color: Colors.red[400],
            fit: fit,

          ),
       // ),
      ),
      filterQuality: FilterQuality.low,
      fit: fit,
      fadeInDuration: fadeInDuration,
      progressIndicatorBuilder: (context, url, downloadProgress) => Align(
        alignment: Alignment.center,
        child: LimitedBox(
          maxHeight: 6,
          maxWidth: 6,
          child: CircularProgressIndicator(
            color: Styles.colorPrimary,
            value: downloadProgress.progress,
          ),
        ),
      ),
    );
  }

  static Widget getAsset(url,
      {BoxFit fit = BoxFit.cover,
      Duration fadeInDuration = const Duration(milliseconds: 500)}) {
    return CachedNetworkImage(
      imageUrl: url ?? '',
      alignment: Alignment.center,
      errorWidget: (context, url, error) => Align(
          alignment: Alignment.center,
          // child: SizedBox(
          //   height: 40,
          //   width: 40,
             child: Image.asset(
              Assets.PNG_SplashImage,
              // size: 40,
              color: Colors.red[400],
               // fit: BoxFit.cover,

               //   ),
          )),
      filterQuality: FilterQuality.low,
      fit: fit,
      fadeInDuration: fadeInDuration,
      progressIndicatorBuilder: (context, url, downloadProgress) => Align(
        alignment: Alignment.center,
        child: LimitedBox(
          maxHeight: 6,
          maxWidth: 6,
          child: CircularProgressIndicator(
            color: Styles.colorPrimary,
            value: downloadProgress.progress,
          ),
        ),
      ),
    );
  }
}
