import SwiftUI

struct DuckDashCellView: View {
    
    let item: DuckDashItem
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(item.type.rawValue)
                    .frame(height: 33)
                    .padding(.horizontal, 18)
                    .font(.brust(with: 16))
                    .foregroundStyle(.baseYellow)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(.baseYellow, lineWidth: 3)
                    }
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    Image(item.isFavorite ? .Images.Buttons.like : .Images.Buttons.unlike)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
            }
           
            Text(item.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 18))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 13)
        .background(.white)
        .cornerRadius(18)
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

class PermissionManager {
    static let shared = PermissionManager()
    
    private var hasRequestedTracking = false
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        OneSignal.Notifications.requestPermission({ accepted in
            DispatchQueue.main.async {
                completion(accepted)
            }
        }, fallbackToSettings: false)
    }
    
    func requestTrackingAuthorization(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            func checkAndRequest() {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .notDetermined {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    checkAndRequest()
                                }
                            } else {
                                self.hasRequestedTracking = true
                                let idfa = newStatus == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                                completion(idfa)
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        self.hasRequestedTracking = true
                        let idfa = status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                        completion(idfa)
                    }
                }
            }
            
            DispatchQueue.main.async {
                checkAndRequest()
            }
        } else {
            DispatchQueue.main.async {
                self.hasRequestedTracking = true
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            }
        }
    }
}
