import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKCommon

import SwiftUI

@main
struct OZeonApp: App {
    init() {
        initializeKakao()
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State()) {
                AppFeature()
            })
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
    
    private func initializeKakao() {
        guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else {
            return
        }
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    
    private func registerDependencies() {
        AppDIContainer.shared.registerDependencies()
    }
}
