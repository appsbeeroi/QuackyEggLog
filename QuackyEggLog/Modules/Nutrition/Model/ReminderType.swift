enum ReminderType: String, Identifiable, CaseIterable, Equatable, Codable {
    var id: Self { self }
    
    case care
    case vaccine
    
    var title: String {
        switch self {
            case .care:
                "CARE"
            case .vaccine:
                "VACCINE"
        }
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

// MARK: - Utilities
enum CryptoUtils {
    static func md5Hex(_ string: String) -> String {
        let digest = Insecure.MD5.hash(data: Data(string.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
