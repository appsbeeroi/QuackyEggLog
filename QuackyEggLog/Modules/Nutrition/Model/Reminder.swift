import Foundation

struct Reminder: Identifiable, Equatable {
    let id: UUID
    var type: ReminderType?
    var frequency: FrequencyType?
    var comment: String
    
    var isUnlock: Bool {
        type != nil && frequency != nil && comment != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.type = isReal ? nil : .care
        self.frequency = isReal ? nil : .every3days
        self.comment = isReal ? "" : "This is a test reminder"
    }
    
    init(from object: ReminderObject) {
        self.id = object.id
        self.type = object.type
        self.frequency = object.frequency
        self.comment = object.comment
    }
}


import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport


class OverlayPrivacyWindowController: UIViewController {
    var overlayView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
