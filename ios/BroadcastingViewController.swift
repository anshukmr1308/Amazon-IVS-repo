//import UIKit
//import AmazonIVSBroadcast
//
//class BroadcastingViewController: UIViewController {
//    var channelId: String?
//    var streamKey: String?
//    
//    private var broadcaster: IVSBroadcaster?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupBroadcasting()
//    }
//    
//    private func setupBroadcasting() {
//        guard let channelId = channelId, let streamKey = streamKey else { return }
//        
//        // Initialize the broadcaster
//        broadcaster = IVSBroadcaster(channelId: channelId, streamKey: streamKey)
//        
//        // Start broadcasting
//        broadcaster?.start { error in
//            if let error = error {
//                print("Error starting broadcast: \(error.localizedDescription)")
//            } else {
//                print("Broadcast started successfully")
//            }
//        }
//        
//        // Setup UI for broadcasting (e.g., camera preview)
//        setupCameraPreview()
//    }
//    
//    private func setupCameraPreview() {
//        // Create a preview layer for the camera
//        let previewLayer = broadcaster?.previewLayer
//        previewLayer?.frame = view.bounds
//        previewLayer?.videoGravity = .resizeAspectFill
//        if let previewLayer = previewLayer {
//            view.layer.addSublayer(previewLayer)
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        // Stop broadcasting when the view is dismissed
//        broadcaster?.stop()
//    }
//}
