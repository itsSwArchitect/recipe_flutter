import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ads
{
  int value=0;

  Future adCounterSaver(String counter,int valuez) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();

   await prefs.setInt(counter, valuez);
    int value= prefs.getInt('counter');
   return value;

  }





  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }


  void initalizeAndBanner() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }
  void showInterstitialAd () {

value++;

 adCounterSaver('counter', value);

print("CounterValue $value");

if(value >=2){
    createInterstitialAd()
      ..load()
      ..show();
value=0;
}
  }

  void dispose ()
  {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    print('DisPoseCalled');
  }
 /* void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }
*/



}