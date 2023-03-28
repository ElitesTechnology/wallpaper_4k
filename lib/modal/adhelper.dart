import 'dart:io';

class AdHelper{

  static String homepageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-4315370393791663/7577316469";
    }
    else {
      return "";
    }
  }
    static String subPageBanner() {
      if (Platform.isAndroid) {
        return "ca-app-pub-4315370393791663/6264234795";
      }
      else {
        return "";
      }
    }
      static String fullPageAd() {
        if(Platform.isAndroid){
          return "ca-app-pub-4315370393791663/1011908116";
        }
        else{
          return "";
        }
}
}