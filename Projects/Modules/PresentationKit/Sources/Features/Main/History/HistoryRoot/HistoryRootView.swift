//
//  HistoryRootView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct HistoryRootView: View {
    
    public init(store: StoreOf<HistoryRoot>) {
        self.store = store
    }
    
    private let store: StoreOf<HistoryRoot>
    
    public var body: some View {
        SwitchStore(store) { state in
            switch state {
            case .emptyHistory:
                CaseLet(
                    /HistoryRoot.State.emptyHistory,
                    action: HistoryRoot.Action.emptyHistory
                ) { store in
                    EmptyHistoryView(store: store)
                }
            case .mainHistory:
                CaseLet(
                    /HistoryRoot.State.mainHistory,
                     action: HistoryRoot.Action.mainHistory
                ) { store in
                    MainHistoryView(store: store)
                }
            }
        }
    }
}

#if DEBUG
struct HistoryRootView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRootView(store: .init(initialState: HistoryRoot.State()) {
            HistoryRoot()
        })
    }
}
#endif
