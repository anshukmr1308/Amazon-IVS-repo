////
////  IVSManager.swift
////  AmazonIVSProject
////
////  Created by macmini on 01/01/25.
////
//import Foundation
//import React
//
//@objc(IVSManager)
//class IVSManager: NSObject {
//  @objc func createStage(_ userId: String, username: String, avatarUrl: String?, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
//        let apiUrl = "https://5j27lyi8yb.execute-api.us-east-1.amazonaws.com/prod-12211057raj/"
//      
//    let url = URL(string: "\(apiUrl)/create")!
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            let body: [String: Any] = [
//                "userId": userId,
//                "attributes": [
//                    "username": username,
//                    "avatarUrl": avatarUrl
//                ],
//                "id": ""
//            ]
//            
//            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    reject("ERR_CREATE_STAGE", "Failed to create stage: \(error.localizedDescription)", error)
//                    return
//                }
//                
//                guard let data = data else {
//                    reject("ERR_CREATE_STAGE", "No data received", nil)
//                    return
//                }
//                
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    resolve(json)
//                } else {
//                    reject("ERR_CREATE_STAGE", "Failed to parse response", nil)
//                }
//            }
//            
//            task.resume()
////        guard let url = URL(string: "\(apiUrl)/\'create'") else {
////            rejecter("URL_ERROR", "Invalid URL", nil)
////            return
////        }
////
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
////
////        do {
////            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
////            request.httpBody = jsonData
////        } catch {
////            rejecter("JSON_ERROR", "Failed to serialize JSON", error)
////            return
////        }
////
////        let session = URLSession.shared
////        session.dataTask(with: request) { data, response, error in
////            if let error = error {
////                rejecter("REQUEST_ERROR", "Failed to create stage", error)
////                return
////            }
////
////            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
////                rejecter("API_ERROR", "Invalid response from server", nil)
////                return
////            }
////
////            guard let data = data else {
////                rejecter("NO_DATA", "No data in response", nil)
////                return
////            }
////
////            do {
////                let responseObject = try JSONSerialization.jsonObject(with: data, options: [])
////                resolver(responseObject)
////            } catch {
////                rejecter("PARSE_ERROR", "Failed to parse response", error)
////            }
////        }.resume()
//    }
//
//    @objc static func requiresMainQueueSetup() -> Bool {
//        return false
//    }
//}
