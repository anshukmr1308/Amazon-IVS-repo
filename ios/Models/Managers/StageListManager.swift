//import Foundation
//import SwiftUI
//import React
//
//@objc(StageListManager)
//class StageListManager: RCTViewManager {
//    override func view() -> UIView! {
//        let hostingController = UIHostingController(
//            rootView: StageList(
//                isPresent: .constant(false),
//                isLoading: .constant(false),
//                onSelect: { stage in
//                    self.notifySelectStage(stage: stage)
//                },
//                onCreate: {
//                    self.notifyCreateStage()
//                }
//            )
//        )
//        return hostingController.view
//    }
//
//    @objc func notifyCreateStage() {
//        // Log and display an alert to verify the function is triggered
//        print("✅ notifyCreateStage called from React Native")
//        DispatchQueue.main.async {
//            if let topController = UIApplication.shared.windows.first?.rootViewController {
//                let alert = UIAlertController(title: "Stage Created", message: "The 'Create New Stage' button was pressed in React Native.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                topController.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//
//     func notifySelectStage(stage: StageDetails) {
//        print("✅ notifySelectStage called with stage: \(stage.stageId)")
//    }
//
//    override static func requiresMainQueueSetup() -> Bool {
//        return true
//    }
//}
//
//class StageListUIView: UIView {
//    static var onCreate: (() -> Void)?
//    
//    private let hostingController: UIHostingController<StageList>
//
//    override init(frame: CGRect) {
//        let isPresent = Binding.constant(false)
//        let isLoading = Binding.constant(false)
//
//        hostingController = UIHostingController(
//            rootView: StageList(
//                isPresent: isPresent,
//                isLoading: isLoading,
//                onSelect: { _ in },
//                onCreate: { StageListUIView.onCreate?() } // Pass onCreate callback
//            )
//        )
//        super.init(frame: frame)
//        setupHostingController()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupHostingController() {
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(hostingController.view)
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            hostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//    }
//
//    func configure(isPresent: Binding<Bool>, isLoading: Binding<Bool>, onSelect: @escaping (StageDetails) -> Void, onCreate: @escaping () -> Void) {
//        StageListUIView.onCreate = onCreate
//        hostingController.rootView = StageList(
//            isPresent: isPresent,
//            isLoading: isLoading,
//            onSelect: onSelect,
//            onCreate: onCreate
//        )
//    }
//}
