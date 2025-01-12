// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/constant_ad_ids.dart';

class AdsController extends GetxController {
  // Ad variables
  final Rx<BannerAd?> _bannerAd = Rx<BannerAd?>(null);
  final Rx<BannerAd?> _bannerAd2 = Rx<BannerAd?>(null);
  final Rx<InterstitialAd?> _interstitialAd = Rx<InterstitialAd?>(null);
  final Rx<AppOpenAd?> _appOpenAd = Rx<AppOpenAd?>(null);

  // Ad readiness status
  final _isInterstitialAdReady = false.obs;
  final _isBannerAdReady = false.obs;
  final _isBannerAd2Ready = false.obs;
  final _isAppOpenAdReady = false.obs;
  final _isLoadingOpenAd = false.obs;

  // Getters
  bool get isInterstitialAdReady => _isInterstitialAdReady.value;
  bool get isAppOpenAdReady => _isAppOpenAdReady.value;
  bool get isBannerAdReady => _isBannerAdReady.value;
  bool get isBannerAd2Ready => _isBannerAd2Ready.value;
  bool get isLoadingOpenAd => _isLoadingOpenAd.value;

  InterstitialAd? get interstitialAd => _interstitialAd.value;
  BannerAd? get bannerAd => _bannerAd.value;
  BannerAd? get bannerAd2 => _bannerAd2.value;

  @override
  void onInit() {
    super.onInit();
    loadAppOpenAd();
    // loadBannerAd2();
    _bannerAd.value = _createBannerAd(isHomeBanner: true);
    _bannerAd.value?.load();
    loadInterstitialAd();
  }

  // Load Banner Ads
  BannerAd _createBannerAd({bool isHomeBanner = false}) {
    return BannerAd(
      size: AdSize.banner,
      adUnitId: BANNER_AD,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (isHomeBanner) {
            _isBannerAdReady.value = true;
          } else {
            _isBannerAd2Ready.value = true;
          }
          if (kDebugMode) {
            print("Banner Ad loaded");
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (isHomeBanner) {
            _isBannerAdReady.value = false;
          } else {
            _isBannerAd2Ready.value = false;
          }
          if (kDebugMode) {
            log("^^^^^^^^^^^^^^^^erro1 $error");
            print("Banner Ad failed to load: $error");
          }
        },
      ),
      request: const AdRequest(),
    );
  }

  // Load Interstitial Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-9595969837796228/9466701255",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd.value = ad;
          _isInterstitialAdReady.value = true;
          if (kDebugMode) {
            print('Interstitial Ad loaded');
          }
        },
        onAdFailedToLoad: (error) {
          _isInterstitialAdReady.value = false;
          if (kDebugMode) {
            log("^^^^^^^^^^^^^^^^erro2 $error");
            print('Interstitial Ad failed to load: $error');
          }
        },
      ),
    );
  }

  // Load App Open Ad
  void loadAppOpenAd() async {
    if (_isAppOpenAdReady.value) return;
    _isLoadingOpenAd.value = true;

    await AppOpenAd.load(
      adUnitId: APP_OPEN_AD,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _isLoadingOpenAd.value = false;
          _appOpenAd.value = ad;
          _isAppOpenAdReady.value = true;
          // FlutterNativeSplash.remove();
          showAppOpenAd();
          if (kDebugMode) {
            print("App Open Ad loaded");
          }
        },
        onAdFailedToLoad: (error) {
          _isLoadingOpenAd.value = false;
          // FlutterNativeSplash.remove();
          if (kDebugMode) {
            print("App Open Ad failed to load: $error");
          }
        },
      ),
    );
  }

  // Show App Open Ad
  void showAppOpenAd() {
    if (_appOpenAd.value == null) {
      if (kDebugMode) {
        print('Tried to show App Open Ad before loaded.');
      }
      return;
    }

    _appOpenAd.value!.show();
    _appOpenAd.value?.dispose();
    _isAppOpenAdReady.value = false;
  }

  // Show Interstitial Ad
  void showInterstitialAd({Function? onComplete}) {
    if (_interstitialAd.value == null) {
      if (kDebugMode) {
        print('Tried to show Interstitial Ad before loaded.');
      }
      return;
    }

    _interstitialAd.value!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        if (kDebugMode) {
          print('Interstitial Ad showed full screen content.');
        }
      },
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd();
        _isInterstitialAdReady.value = false;
        if (onComplete != null) {
          onComplete();
        }
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitialAd();
        if (kDebugMode) {
          print('Interstitial Ad failed to show full screen content: $error');
        }
      },
      onAdImpression: (ad) {
        if (kDebugMode) {
          print('Interstitial Ad impression recorded.');
        }
      },
    );

    _interstitialAd.value!.show();
    _isInterstitialAdReady.value = false;
  }

  // Load Second Banner Ad
  void loadBannerAd2() {
    if (!_isBannerAd2Ready.value) {
      _bannerAd2.value = _createBannerAd();
      _bannerAd2.value?.load();
    }
  }

  @override
  void dispose() {
    _bannerAd.value?.dispose();
    _bannerAd2.value?.dispose();
    _interstitialAd.value?.dispose();
    _appOpenAd.value?.dispose();

    super.dispose();
  }
}
