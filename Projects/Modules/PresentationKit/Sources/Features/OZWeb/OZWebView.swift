//
//  OZWebView.swift
//  PresentationKit
//
//  Created by 고병학 on 10/1/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI
import WebKit

struct OZWebViewWrapped: UIViewRepresentable {
    var urlToLoad: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad) else {
            return WKWebView()
        }
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<OZWebViewWrapped>) {
    }
}

public struct OZWebView: View {
    
    public init(store: StoreOf<OZWeb>) {
        self.store = store
    }
    
    let store: StoreOf<OZWeb>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            OZWebViewWrapped(urlToLoad: "https://www.naver.com")
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            viewStore.send(.didTapBackButton)
                        }, label: {
                            Image.DK.icBack24.swiftUIImage
                                .frame(width: 24, height: 24)
                        })
                    }
                }
        }
    }
}

#if DEBUG
struct OZWebView_Previews: PreviewProvider {
    static var previews: some View {
        OZWebView(store: .init(initialState: OZWeb.State()) {
            OZWeb()
        })
    }
}
#endif
