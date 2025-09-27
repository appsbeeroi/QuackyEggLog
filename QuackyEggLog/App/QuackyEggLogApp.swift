import SwiftUI

@main
struct QuackyEggLogApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BlackWindow(rootView: MainView(), remoteConfigKey: AppConstants.remoteConfigKey)
        }
    }
}

struct AppConstants {
    static let metricsBaseURL = "https://egquackyg.com/app/metrics"
    static let salt = "0ZTQXBKGq399NJNXknZ1uPOo3TGmQW0K"
    static let oneSignalAppID = "ff8583e2-1069-4d68-b11d-0f839088a080"
    static let userDefaultsKey = "quacky"
    static let remoteConfigStateKey = "quackyEggLog"
    static let remoteConfigKey = "QuackyEggLogIsEnable"
}
