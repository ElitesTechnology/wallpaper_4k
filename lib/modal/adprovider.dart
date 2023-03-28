import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'adhelper.dart';

class AdProvider with ChangeNotifier {

  bool isHomePageBannerLoaded = false;
  late BannerAd homePageBanner;

  bool isSubPageBannerLoaded = false;
  late BannerAd subPageBanner;

  bool isFullPageBannerLoaded = false;
  late BannerAd fullPageBanner;

  void initializedHomePageBanner() async {
    homePageBanner =
        BannerAd(size: AdSize.banner,
            adUnitId: AdHelper.homepageBanner(),
            request: AdRequest(),
          listener: BannerAdListener(
            onAdLoaded: (ad){
              print(ad);
              isHomePageBannerLoaded = true;
            },
            onAdClosed: (ad){
              ad.dispose();
              isHomePageBannerLoaded = false;
            },
            onAdFailedToLoad: (ad, err){
              isHomePageBannerLoaded = false;
            }
          ),
        );
    await homePageBanner.load();
    notifyListeners();
  }

  void initializedSubPageBanner() async {
    subPageBanner =
        BannerAd(size: AdSize.banner,
          adUnitId: AdHelper.subPageBanner(),
          request: AdRequest(),
          listener: BannerAdListener(
              onAdLoaded: (ad){
                isSubPageBannerLoaded = true;
              },
              onAdClosed: (ad){
                ad.dispose();
                isSubPageBannerLoaded = false;
              },
              onAdFailedToLoad: (ad, err){
                isSubPageBannerLoaded = false;
              }
          ),
        );
    await subPageBanner.load();
    notifyListeners();
  }

  void initializedFullPageAd() async{
    await InterstitialAd.load(adUnitId: AdHelper.fullPageAd(),
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad){
              fullPageBanner = ad as BannerAd;
              isFullPageBannerLoaded = true;
            },
            onAdFailedToLoad: (err){
              isFullPageBannerLoaded = false;
            })
    );
    notifyListeners();
  }
}