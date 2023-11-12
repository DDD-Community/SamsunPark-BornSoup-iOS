//
//  WriteHistoryView.swift
//  PresentationKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI

public struct WriteHistoryView: View {
    
    public init(store: StoreOf<WriteHistory>) {
        self.store = store
    }
    
    private let store: StoreOf<WriteHistory>
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("기록 작성 뷰")
        }
    }
}

#if DEBUG
struct WriteHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WriteHistoryView(store: .init(initialState: WriteHistory.State()) {
            WriteHistory()
        })
    }
}
#endif
