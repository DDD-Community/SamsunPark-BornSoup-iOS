//
//  EmptyHistoryView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct EmptyHistoryView: View {
    
    public init(store: StoreOf<EmptyHistory>) {
        self.store = store
    }
    
    private let store: StoreOf<EmptyHistory>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("최초 기록 뷰")
        }
    }
}

#if DEBUG
struct EmptyHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyHistoryView(store: .init(initialState: EmptyHistory.State()) {
            EmptyHistory()
        })
    }
}
#endif
