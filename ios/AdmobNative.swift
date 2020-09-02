

@objc(AdmobNative)
class AdmobNative: NSObject {

    @objc(withResolver:withRejecter:)
	func loadAd(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) -> Void {
		let admobDelegate = AdmobDelegateResolver(adUnitID: "", resolve: resolve, reject: reject)
		admobDelegate.load()
    }
}


