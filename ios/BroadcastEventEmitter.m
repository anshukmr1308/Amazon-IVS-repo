//
//  BroadcastEventEmitter.m
//  AmazonIVSProject
//
//  Created by macmini on 21/01/25.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(BroadcastEventEmitter, RCTEventEmitter)
RCT_EXTERN_METHOD(supportedEvents)
RCT_EXTERN_METHOD(emitPreviewPageState:(BOOL)isPreviewPage) // Add this line
@end
