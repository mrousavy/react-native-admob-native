//
//  AdmobDelegateResolver.swift
//  AdmobNative
//
//  Created by Marc Rousavy on 02.09.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

func getRootViewController() -> UIViewController? {
	return UIApplication.sharedApplication().keyWindow?.rootViewController
}

class AdmobDelegateResolver: GADUnifiedNativeAdLoaderDelegate {
	var adLoader: GADAdLoader!
	var resolver: RCTPromiseResolveBlock
	var rejecter: RCTPromiseRejectBlock

	init(adUnitID: String, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
		self.resolver = resolve
		self.rejecter = reject
		
		let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
		multipleAdsOptions.numberOfAds = 1

		adLoader = GADAdLoader(adUnitID: adUnitID, rootViewController: getRootViewController(),
			adTypes: [GADAdLoaderAdType.unifiedNative],
			options: [multipleAdsOptions])
		adLoader.delegate = self
		adLoader.load(GADRequest())
	}
	
	public func load() {
		adLoader.load(GADRequest())
	}

	func adLoader(_ adLoader: GADAdLoader,
				didReceive nativeAd: GADUnifiedNativeAd) {
		self.resolver(nativeAd)
	}

	func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
		// The adLoader has finished loading ads, and a new request can be sent.
	}
	
	func adLoader(_ adLoader: GADAdLoader,
				  didFailToReceiveAdWithError error: GADRequestError) {
		self.rejecter("ERROR_RECEIVING_AD", error.localizedDescription, error)
	}
}
