//
//  AmazonIVSPlayerViewManager.m
//  AmazonIVSProject
//
//  Created by macmini on 01/01/25.
//

// PermissionsManager.m

#import "AmazonIVSProject-Bridging-Header.h"
#import <AVFoundation/AVFoundation.h>

@implementation PermissionsManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(checkAVPermissions:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    [self checkOrGetPermissionForMediaType:AVMediaTypeVideo completion:^(BOOL videoGranted) {
        if (!videoGranted) {
            resolve(@(NO));
            return;
        }
        [self checkOrGetPermissionForMediaType:AVMediaTypeAudio completion:^(BOOL audioGranted) {
            resolve(@(audioGranted));
        }];
    }];
}

- (void)checkOrGetPermissionForMediaType:(AVMediaType)mediaType
                              completion:(void (^)(BOOL granted))completion {
    switch ([AVCaptureDevice authorizationStatusForMediaType:mediaType]) {
        case AVAuthorizationStatusAuthorized:
            completion(YES);
            break;
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(granted);
                });
            }];
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
        default:
            completion(NO);
            break;
    }
}

@end
