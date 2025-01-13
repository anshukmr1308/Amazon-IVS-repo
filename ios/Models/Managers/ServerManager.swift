import Foundation

@objc(ServerManager)
class ServerManager: NSObject, ObservableObject {
    private let apiUrl = "https://5j27lyi8yb.execute-api.us-east-1.amazonaws.com/prod-12211057raj"
    private let decoder = JSONDecoder()
    
  var viewModel: AmazonIVSBroadcastView?
  
    static let shared = ServerManager()
  private var stageData: [String: Any]? = [
          "status": "default",
          "message": "No data available"
      ]
  
//  weak var delegate: ServerManagerDelegate? {
//         didSet {
//             print("Delegate has been set to: \(String(describing: delegate))")
//         }
//     }
    
    // MARK: - Get Stage Data
    @objc func getStageData() -> [String: Any]? {
      return stageData
    }
    
    // MARK: - Create Stage
  @objc func createStage(
      _ userId: String,
      username: String,
      avatarUrl: String,
      resolve: @escaping RCTPromiseResolveBlock,
      reject: @escaping RCTPromiseRejectBlock
  ) {
      let url = URL(string: "\(apiUrl)/create")!
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
      
      let body: [String: Any] = [
          "userId": userId,
          "attributes": [
              "username": username,
              "avatarUrl": avatarUrl
          ],
          "id": ""
      ]
      
      request.httpBody = try? JSONSerialization.data(withJSONObject: body)
      
      URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
          if let error = error {
              reject("Error", "Failed to create stage: \(error.localizedDescription)", error)
              return
          }
          
          guard let data = data else {
              reject("NoData", "No data received", nil)
              return
          }
        
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//              self?.viewModel?.responce = jsonResponse
              DispatchQueue.main.async { [self] in
                    
                    self?.stageData = jsonResponse
                    // Log the stage data to verify its structure
//                    if let stage = jsonResponse["stage"] as? [String: Any] {
//                        print("Stage data from response: \(stage)")
//                    } else {
//                        print("No stage data found in response")
//                    }
                  
                  print("Delegate method about to be called")
                
//                  self?.delegate?.didUpdateStageData(data: "Anshu")
                }
                resolve(jsonResponse)
            }
        } catch {
            reject("ParseError", "Failed to parse response", error)
        }
      }.resume()
  }
    
    // MARK: - Get All Stages
    @objc func getAllStages(
        _ resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        sendRequest(method: "POST", endpoint: "list") { result in
            switch result {
            case .success(let jsonResponse):
                resolve(jsonResponse)
            case .failure(let error):
                reject("Error", error.localizedDescription, nil)
            }
        }
    }
    
    // MARK: - Join Stage
    @objc func joinStage(
        _ groupId: String,
        userId: String,
        username: String,
        avatarUrl: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = [
            "groupId": groupId,
            "userId": userId,
            "attributes": [
                "avatarUrl": avatarUrl,
                "username": username
            ]
        ]
        
        sendRequest(method: "POST", endpoint: "join", body: body) { result in
            switch result {
            case .success(let jsonResponse):
                resolve(jsonResponse)
            case .failure(let error):
                reject("Error", error.localizedDescription, nil)
            }
        }
    }
    
    // MARK: - Delete Stage
    @objc func deleteStage(
        _ groupId: String,
        resolve: @escaping RCTPromiseResolveBlock,
        reject: @escaping RCTPromiseRejectBlock
    ) {
        let body: [String: Any] = ["groupId": groupId]
        
        sendRequest(method: "DELETE", endpoint: "delete", body: body) { result in
            switch result {
            case .success:
                resolve(true)
            case .failure(let error):
                reject("Error", error.localizedDescription, nil)
            }
        }
    }
    
    // MARK: - Disconnect
    @objc func disconnect(
        _ participantId: String,
        groupId: String,
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
        
        sendRequest(method: "POST", endpoint: "disconnect", body: body) { result in
            switch result {
            case .success:
                resolve(true)
            case .failure(let error):
                reject("Error", error.localizedDescription, nil)
            }
        }
    }
    
    // MARK: - Common Send Request Method
    private func sendRequest(
        method: String,
        endpoint: String,
        body: [String: Any]? = nil,
        completion: @escaping (Result<[String: Any], Error>) -> Void
    ) {
        guard let url = URL(string: "\(apiUrl)/\(endpoint)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 10
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 500, userInfo: nil)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                let statusError = NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(statusError))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "NoData", code: 204, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(jsonResponse))
                } else {
                    let parseError = NSError(domain: "ParseError", code: 500, userInfo: nil)
                    completion(.failure(parseError))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
