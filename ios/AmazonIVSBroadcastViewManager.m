//
//  AmazonIVSBroadcastViewManager.m
//  AmazonIVSProject
//
//  Created by macmini on 02/01/25.
//

//#import <React/RCTViewManager.h>
//
//@interface RCT_EXTERN_MODULE(AmazonIVSBroadcastViewManager, RCTViewManager)
//
//RCT_EXPORT_VIEW_PROPERTY(ingestEndpoint, NSString)
//RCT_EXPORT_VIEW_PROPERTY(streamKey, NSString)
//RCT_EXTERN_METHOD(stopBroadcast:(nonnull NSNumber *)node)
//
//@end


#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>


@interface RCT_EXTERN_MODULE(AmazonIVSBroadcastViewManager, RCTViewManager)
RCT_EXTERN_METHOD(createStageFromReact)
@end

