import SwiftUI

struct DuckDashFavoritesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: DashViewModel
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 16) {
                navigationView
                
                if viewModel.favorites.isEmpty {
                    stumb
                } else {
                    favoritesList
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
            .animation(.easeInOut, value: viewModel.favorites)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigationView: some View {
        ZStack {
            Text("FAVORITES")
                .font(.brust(with: 35))
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .lineLimit(2)
            
            HStack {
                Button {
                     dismiss()
                } label: {
                    Image(.Images.Buttons.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var stumb: some View {
        VStack {
            Text("You have no data\nyet")
                .font(.brust(with: 40))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var favoritesList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 13) {
                ForEach(viewModel.favorites) { item in
                    DuckDashCellView(item: item) {
                        viewModel.changeFavoriteStatus(of: item)
                    }
                }
            }
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

struct TrackingURLBuilder {
    static func buildTrackingURL(from response: MetricsResponse, idfa: String?, bundleID: String) -> URL? {
        let onesignalId = OneSignal.User.onesignalId
        
        if response.isOrganic {
            guard var components = URLComponents(string: response.url) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = components.queryItems ?? []
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
            } else {
                print("OneSignal ID not available for organic URL")
            }
            
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let url = components.url else {
                return nil
            }
            print(url)
            return url
        } else {
            let subId2 = response.parameters["sub_id_2"]
            let baseURLString = subId2 != nil ? "\(response.url)/\(subId2!)" : response.url
            
            guard var newComponents = URLComponents(string: baseURLString) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = []
            queryItems = response.parameters
                .filter { $0.key != "sub_id_2" }
                .map { URLQueryItem(name: $0.key, value: $0.value) }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            
            // Add OneSignal ID
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
                print("🔗 Added OneSignal ID to non-organic URL: \(onesignalId)")
            } else {
                print("⚠️ OneSignal ID not available for non-organic URL")
            }
            
            newComponents.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let finalURL = newComponents.url else {
                return nil
            }
            print(finalURL)
            return finalURL
        }
    }
}

