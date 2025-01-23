//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

//#import <React/RCTBridgeModule.h>
//#import <React/RCTViewManager.h>
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "React/RCTViewManager.h"
#import <AmazonIVSBroadcast/AmazonIVSBroadcast.h>
#import <AmazonIVSBroadcast/IVSBase.h>
#import <AmazonIVSBroadcast/IVSStage.h>
#import <React/RCTEventDispatcher.h>

@interface PermissionsManager : NSObject <RCTBridgeModule>
@end

//@interface RCT_EXTERN_MODULE(AmazonIVSBroadcastViewManager, RCTViewManager)
//RCT_EXTERN_METHOD(createStage: (RCTPromiseResolveBlock)resolve
//                  rejecter:(RCTPromiseRejectBlock)reject)

@interface RCT_EXTERN_MODULE(AmazonIVSBroadcastViewManager, RCTViewManager)
RCT_EXTERN_METHOD(createStageFromReact)



@end

