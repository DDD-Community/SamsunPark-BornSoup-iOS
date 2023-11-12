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
        WithViewStore(store, observe: { $0 }) { viewStore in
            EmptyHistoryView(store: .init(
                initialState: EmptyHistory.State(),
                reducer: { EmptyHistory() }
            ))
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
