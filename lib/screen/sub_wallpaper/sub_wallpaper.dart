import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../sub_page/sub_page.dart';

class Sub_Wallpaper extends StatelessWidget {
  List title;
  Sub_Wallpaper(this.title){ _initAd();}

  bool _isLoaded = false;
  late InterstitialAd _interstitialAd;


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



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xF7060709),
          title: Text('4K Wallpaper'),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            if (_isLoaded) {
              _interstitialAd.show();
            }
            Navigator.pop(context);
          },),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: title.length,
            itemBuilder: (context, index) {
              if (index % 11 == 0) {
                return getAd();
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Wallpaper_Page(title[index]["image1"])));
                },
                child: Card(
                    margin: EdgeInsets.all(2),
                    child: Container(
                      height: 300,
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage(title[index]["image1"].toString()),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    )),
              );
            }),

      ),
      onWillPop: ()async{
        return false;
      },
    );
  }

  onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isLoaded = true;
  }

  Widget getAd() {
    BannerAdListener bannerAdListener = BannerAdListener(
        onAdWillDismissScreen: (ad) {
          ad.dispose();
        });
    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-3940256099942544/6300978111"
            : "ca-app-pub-3940256099942544~1458002511",
        listener: bannerAdListener,
        request:const AdRequest());
    bannerAd.load();
    return SizedBox(
      height: 100,
      child: AdWidget(ad: bannerAd,),
    );
  }
}
