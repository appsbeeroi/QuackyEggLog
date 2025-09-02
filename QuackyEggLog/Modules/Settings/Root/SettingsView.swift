import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isNotificationEnable") var isNotificationEnable = false
    
    @Binding var isShowTabBar: Bool
    
    @State private var notificationOptions: [NotificationOptions] = []
    @State private var selectedSettingsType: SettingsType? = nil
    
    @State private var isShowNotificationsOptions = false
    @State private var isShowSettingsAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                
                VStack(spacing: 16) {
                    navigationView
                    
                    VStack(spacing: 12) {
                        ForEach(SettingsType.allCases) { type in
                            SettingsCell(type: type) {
                                if type == .notifications {
                                    isShowNotificationsOptions.toggle()
                                } else {
                                    isShowTabBar = false
                                    selectedSettingsType = type
                                }
                            }
                            
                            if type == .notifications && isShowNotificationsOptions {
                                VStack(spacing: 0) {
                                    ForEach(NotificationOptions.allCases) { option in
                                        NotificationOptionCellView(option: option, notificationOptions: $notificationOptions)
                                    }
                                }
                                .cornerRadius(18)
                            }
                        }
                    }
                    .animation(.easeIn, value: isShowNotificationsOptions)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 35)
                
                if let selectedSettingsType,
                   let url = URL(string: selectedSettingsType.path) {
                    WebView(url: url) {
                        self.selectedSettingsType = nil
                        self.isShowTabBar = true
                    }
                    .ignoresSafeArea(edges: [.bottom])
                }
            }
            .onAppear {
                notificationOptions = NotificationOptionsStorage.saved
                isShowNotificationsOptions = isNotificationEnable && !notificationOptions.isEmpty
            }
            .onChange(of: notificationOptions) { newValue in
                NotificationOptionsStorage.saved = newValue
            }
            .onChange(of: isShowNotificationsOptions) { isShow in
                Task {
                    if isShow {
                        switch await NotificationManager.shared.authorizationStatus {
                            case .authorized:
                                isNotificationEnable = true
                            default:
                                isNotificationEnable = false
                                isShowSettingsAlert = true
                        }
                    } else {
                        isNotificationEnable = false
                    }
                }
            }
            .alert("Notification permision is required. Open settings?", isPresented: $isShowSettingsAlert) {
                Button("Yes") {
                    openAppSettings()
                }
                
                Button("No") {
                    isShowNotificationsOptions = false
                }
            }
        }
    }
    
    private var navigationView: some View {
        Text("SETTINGS")
            .font(.brust(with: 35))
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
            .lineLimit(2)
    }
    
    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}


