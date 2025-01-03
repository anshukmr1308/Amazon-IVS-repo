//
//  ServerManager.swift
//  AmazonIVSProject
//
//  Created by macmini on 01/01/25.
//

//import Foundation
//
//@objc(ServerManager)
//class ServerManager: NSObject {
//    @objc func createStage(
//        _ userId: String,
//        username: String,
//        avatarUrl: String,
//        resolve: @escaping RCTPromiseResolveBlock,
//        reject: @escaping RCTPromiseRejectBlock
//    ) {
//      let apiUrl = "https://5j27lyi8yb.execute-api.us-east-1.amazonaws.com/prod-12211057raj/"
//      
//        let url = URL(string: "\(apiUrl)/create")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        
//        let body: [String: Any] = [
//            "userId": userId,
//            "attributes": [
//                "username": username,
//                "avatarUrl": avatarUrl
//            ]
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                reject("Error", "Failed to create stage: \(error.localizedDescription)", error)
//                return
//            }
//            
//            guard let data = data else {
//                reject("NoData", "No data received", nil)
//                return
//            }
//            
//            do {
//                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//                resolve(jsonResponse)
//            } catch {
//                reject("ParseError", "Failed to parse response", error)
//            }
//        }.resume()
//    }
//}


import Foundation

@objc(ServerManager)
class ServerManager: NSObject {
    private let apiUrl = "https://5j27lyi8yb.execute-api.us-east-1.amazonaws.com/prod-12211057raj"
    
    // MARK: - General Send Method
    private func sendRequest(
        method: String,
        endpoint: String,
        body: [String: Any]?,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        guard let url = URL(string: "\(apiUrl)/\(endpoint)") else {
            reject("InvalidURL", "Failed to create URL for endpoint: \(endpoint)", nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                reject("RequestError", "Request failed: \(error.localizedDescription)", error)
                return
            }
            
            guard let data = data else {
                reject("NoData", "No data received", nil)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                resolve(jsonResponse)
            } catch {
                reject("ParseError", "Failed to parse response: \(error.localizedDescription)", error)
            }
        }.resume()
    }
    
    // MARK: - Create Stage
    @objc func createStage(
        _ userId: String,
        username: String,
        avatarUrl: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = [
            "userId": userId,
            "attributes": [
                "username": username,
                "avatarUrl": avatarUrl
            ]
        ]
        sendRequest(method: "POST", endpoint: "create", body: body, resolve: resolve, reject: reject)
    }
    
    // MARK: - List Stages
    @objc func listStages(
        _ resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        sendRequest(method: "POST", endpoint: "list", body: nil, resolve: resolve, reject: reject)
    }
    
    // MARK: - Join Stage
    @objc func joinStage(
        _ userId: String,
        groupId: String,
        username: String,
        avatarUrl: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = [
            "groupId": groupId,
            "userId": userId,
            "attributes": [
                "username": username,
                "avatarUrl": avatarUrl
            ]
        ]
        sendRequest(method: "POST", endpoint: "join", body: body, resolve: resolve, reject: reject)
    }
    
    // MARK: - Delete Stage
    @objc func deleteStage(
        _ groupId: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = [
            "groupId": groupId
        ]
        sendRequest(method: "DELETE", endpoint: "delete", body: body, resolve: resolve, reject: reject)
    }
    
    // MARK: - Disconnect Participant
    @objc func disconnectParticipant(
        _ groupId: String,
        participantId: String,
        userId: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = [
            "groupId": groupId,
            "participantId": participantId,
            "reason": "Kicked by another user",
            "userId": userId
        ]
        sendRequest(method: "POST", endpoint: "disconnect", body: body, resolve: resolve, reject: reject)
    }
}

