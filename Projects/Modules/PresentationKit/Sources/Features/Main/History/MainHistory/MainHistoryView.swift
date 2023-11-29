//
//  MainHistoryView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct MainHistoryView: View {
    
    public init(store: StoreOf<MainHistory>) {
        self.store = store
    }
    
    private let store: StoreOf<MainHistory>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("메인 기록 뷰")
        }
    }
}

#if DEBUG
struct MainHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MainHistoryView(store: .init(initialState: MainHistory.State()) {
            MainHistory()
        })
    }
}
#endif
