//
//  ServerBridge.m
//  AmazonIVSProject
//
//  Created by macmini on 01/01/25.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ServerManager, NSObject)

// MARK: - Create Stage
RCT_EXTERN_METHOD(createStage:(NSString *)userId
                  username:(NSString *)username
                  avatarUrl:(NSString *)avatarUrl
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

// MARK: - List Stages
RCT_EXTERN_METHOD(listStages:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

// MARK: - Join Stage
RCT_EXTERN_METHOD(joinStage:(NSString *)userId
                  groupId:(NSString *)groupId
                  username:(NSString *)username
                  avatarUrl:(NSString *)avatarUrl
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

// MARK: - Delete Stage
RCT_EXTERN_METHOD(deleteStage:(NSString *)groupId
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

// MARK: - Disconnect Participant
RCT_EXTERN_METHOD(disconnectParticipant:(NSString *)groupId
                  participantId:(NSString *)participantId
                  userId:(NSString *)userId
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

@end


