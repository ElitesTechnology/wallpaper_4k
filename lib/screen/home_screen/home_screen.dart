import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_4k/internet_connetivity/connetivity_provider.dart';
import 'package:wallpaper_4k/internet_connetivity/no_internet.dart';
import 'package:wallpaper_4k/modal/adprovider.dart';
import 'package:wallpaper_4k/modal/model.dart';
import 'package:wallpaper_4k/screen/sub_wallpaper/sub_wallpaper.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  ThemeData _lightTheme =
  ThemeData(brightness: Brightness.light, primaryColor: Colors.grey);
  ThemeData _dartTheme =
  ThemeData(brightness: Brightness.dark, primaryColor: Colors.green);
  bool _light = true;
  BannerAd? _ad;
  bool _isLoaded = false;
  var subcate = [];
  List _item = [];

  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pageui(),
      //      bottomNavigationBar: Consumer<AdProvider>(
      //   builder: (context,adProvider,child){
      //     if(adProvider.isHomePageBannerLoaded){
      //       return Container(
      //         height: adProvider.homePageBanner.size.height.toDouble(),
      //         child: AdWidget(ad: adProvider.homePageBanner,),
      //       );
      //     }
      //     else{
      //       return Container(height: 0,);
      //     }
      //   },
      // ),
    );
  }

  getsubCat({title}) async {
    subcate.clear();
    var data = await rootBundle.loadString("asset/api.json");
    var decode = welcomeFromJson(data);
    var s =
        decode.wallpaper.where((element) => element.title == title).toList();

    for (var e in s[0].subcat) {
      subcate.add(e);
    }
  }

  Widget Pageui() {
    return Consumer<ConnectivityProvider>(
      builder: (context, modal, child) {
        if (modal.isOnline) {
          return modal.isOnline
              ? MaterialApp(
            theme: _light ? _dartTheme : _lightTheme,
                home: Scaffold(
                    drawer: Drawer(
                      backgroundColor: Colors.black,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 200,
                              ),
                              Text(
                                "4K Wallpaper",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Home",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Home_Page();
                                    }));
                                  },
                                  leading: Icon(
                                    Icons.home_filled,
                                    color: Colors.white,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Rate Us",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: (){
                                    LaunchReview.launch(androidAppId: "com.mobirix.swipebrick3");
                                  },
                                  leading: Icon(
                                    Icons.star_border_purple500_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Share App",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    Share.share(
                                        "https://play.google.com/store/apps/details?id=com.king.candycrushsaga");
                                  },
                                  leading: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "About",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: (){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text('This Is Wallpaper App'),
                                        actions: [
                                          ElevatedButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text('Ok'),style: ElevatedButton.styleFrom(backgroundColor: Colors.black),)
                                        ],
                                      );
                                    });
                                  },
                                  leading: Icon(
                                    Icons.info_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.dark_mode_outlined, color: Colors.white,),
                                  title: Text("Change Theme",style: TextStyle( color: Colors.white,),),
                                  trailing: Switch(
                                    value: _light,
                                    onChanged: (state) {
                                      setState(() {
                                        _light = state;
                                      });
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    appBar: AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.black,
                      title: Text(
                        "4K Wallpaper",
                      ),
                    ),
                    body: FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString('asset/api.json'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var mydata = json.decode(snapshot.data.toString());
                          _item = mydata["Wallpaper"];
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _item.length,
                              itemBuilder: (context, index) {
                                if (index % 6 == 0) {
                                  return getAd();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    getsubCat(title: _item[index]["title"]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Sub_Wallpaper(
                                              _item[index]['Subcat']),
                                        ));
                                  },
                                  child: Card(
                                      margin: EdgeInsets.all(10),
                                      child: Container(
                                        height: 150,
                                        child: Stack(
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  _item[index]["image"]),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    _item[index]["title"],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
              )
              : No_INternet();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }


  Widget getAd() {
    BannerAdListener bannerAdListener =
        BannerAdListener(onAdWillDismissScreen: (ad) {
      ad.dispose();
    });
    BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? "ca-app-pub-3940256099942544/6300978111"
            : "ca-app-pub-3940256099942544~1458002511",
        listener: bannerAdListener,
        request: const AdRequest());
    bannerAd.load();
    return SizedBox(
      height: 100,
      child: AdWidget(
        ad: bannerAd,
      ),
    );
  }
}
