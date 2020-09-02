

@objc(AdmobNative)
class AdmobNative: NSObject {

    @objc(withResolver:withRejecter:)
    func load(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
		var admobDelegate = AdmobDelegateResolver(adUnitID: "", resolve: resolve, reject: reject)
		admobDelegate.load()
    }
}
