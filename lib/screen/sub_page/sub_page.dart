import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_4k/screen/favourite/favourite.dart';

class Wallpaper_Page extends StatelessWidget {
  final image;

  Wallpaper_Page(this.image){_initAd();}


  void _initAd() {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/1033173712"
          : "ca-app-pub-3940256099942544/4411468910",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  bool isFav = false;

  bool _isLoaded = false;

  late InterstitialAd _interstitialAd;

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xF7060709),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
        if (_isLoaded) {
          _interstitialAd.show();
        }
        Navigator.pop(context);
      },),
          title: Text('4K Wallpaper'),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: _height * 0.67,
                    width: _width * 0.9,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xBB292A2D),
                          Color(0x83060709),
                          Color(0xBB13151A),
                          Color(0xBB060709),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 10,
                          color: Color(0xD5060709),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.network(
                        "$image",
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.15,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: _height * 0.13,
                  width: _width * 1,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFA060709),
                        Color(0xFA060709),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              downlode();
                              final snackBar = SnackBar(
                                content: const Text('Successfully Download'),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () {},
                                ),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Icon(
                              Icons.download_for_offline_rounded,
                              color: Color(0xD5060709),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFDFAFAFC)),
                          ),
                          SizedBox(
                            width: _width * 0.1,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Share.share(
                                  "https://play.google.com/store/apps/details?id=com.king.candycrushsaga");
                            },
                            child: Icon(
                              Icons.share,
                              color: Color(0xD5060709),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFDFAFAFC)),
                          ),
                          SizedBox(
                            width: _width * 0.1,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Which Screen You Want To Set Wallpaper'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () async {
                                            setWallpaperHomeScreen();
                                            Navigator.pop(context);
                                            // final snackBar = SnackBar(
                                            //   content: Text(
                                            //       'Successfully Set Wallpaper In Home Screen'),
                                            //   action: SnackBarAction(
                                            //     label: 'Ok',
                                            //     onPressed: () {},
                                            //   ),
                                            // );
                                            //
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(snackBar);
                                          },
                                          child: Text('Home Screen'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setWallpaperLockScreen();
                                            // final snackBar = SnackBar(
                                            //   content: Text(
                                            //       'Successfully Set Wallpaper In Lock Screen'),
                                            //   action: SnackBarAction(
                                            //     label: 'Ok',
                                            //     onPressed: () {},
                                            //   ),
                                            // );
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(snackBar);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Lock Screen'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setWallpaper_both_screen();
                                            // final snackBar = SnackBar(
                                            //   content: const Text(
                                            //       'Successfully Set Wallpaper In Both Screen'),
                                            //   action: SnackBarAction(
                                            //     label: 'Ok',
                                            //     onPressed: () {},
                                            //   ),
                                            // );
                                            //
                                            // // Find the ScaffoldMessenger in the widget tree
                                            // // and use it to show a SnackBar.
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(snackBar);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Both Screen'),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Icon(
                              Icons.mobile_friendly,
                              color: Color(0xD5060709),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFDFAFAFC)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      onWillPop: ()async{
        return false;
      },
    );
  }

  downlode() async {
    try {
      var imageId = await ImageDownloader.downloadImage(image);
      if (imageId == null) {
        return;
      }
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } catch (e) {
      debugPrint("$e");
    }
  }

  setWallpaperHomeScreen() async {
    var file = await DefaultCacheManager().getSingleFile(image);
    final result = await WallpaperManager.setWallpaperFromFile(
      file.path,
      WallpaperManager.HOME_SCREEN,
    );
  }

  setWallpaperLockScreen() async {
    var file = await DefaultCacheManager().getSingleFile(image);
    final result = await WallpaperManager.setWallpaperFromFile(
      file.path,
      WallpaperManager.LOCK_SCREEN,
    );
  }

  setWallpaper_both_screen() async {
    var file = await DefaultCacheManager().getSingleFile(image);
    final result = await WallpaperManager.setWallpaperFromFile(
      file.path,
      WallpaperManager.BOTH_SCREEN,
    );
  }

  onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isLoaded = true;
  }
}
