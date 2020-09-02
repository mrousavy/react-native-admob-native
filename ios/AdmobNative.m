#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AdmobNative, NSObject)

RCT_EXTERN_METHOD(loadAd:(RCTPromiseResolveBlock)resolve
				  withRejecter:(RCTPromiseRejectBlock)reject)

@end
