//
//  AdmobDelegateResolver.swift
//  AdmobNative
//
//  Created by Marc Rousavy on 02.09.20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation
import GoogleMobileAds

func getRootViewController() -> UIViewController? {
	return UIApplication.shared.keyWindow?.rootViewController
}

class AdmobDelegateResolver: NSObject, GADUnifiedNativeAdLoaderDelegate {
	var adLoader: GADAdLoader!
	var resolver: RCTPromiseResolveBlock
	var rejecter: RCTPromiseRejectBlock

	init(adUnitID: String, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
		self.resolver = resolve
		self.rejecter = reject
		super.init()
		
		
		let imageAdLoaderOptions = GADNativeAdImageAdLoaderOptions()
		imageAdLoaderOptions.disableImageLoading = true
		
		let mediaAdLoaderOptions = GADNativeAdMediaAdLoaderOptions()
		mediaAdLoaderOptions.mediaAspectRatio = .any
		
		let viewAdOptions = GADNativeAdViewAdOptions()
		viewAdOptions.preferredAdChoicesPosition = .topRightCorner
		
		adLoader = GADAdLoader(adUnitID: adUnitID, rootViewController: getRootViewController(),
			adTypes: [GADAdLoaderAdType.unifiedNative],
			options: [imageAdLoaderOptions, mediaAdLoaderOptions, viewAdOptions])
		adLoader.delegate = self
	}
	
	public func load() {
		adLoader.load(GADRequest())
	}

	// Successfully loaded 1 ad
	func adLoader(_ adLoader: GADAdLoader,
				didReceive nativeAd: GADUnifiedNativeAd) {
		self.resolver(nativeAd)
	}
	
	// Failed to load
	func adLoader(_ adLoader: GADAdLoader,
				  didFailToReceiveAdWithError error: GADRequestError) {
		self.rejecter("ERROR_RECEIVING_AD", error.localizedDescription, error)
	}

	func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
		self.resolver(nil)
	}
}
