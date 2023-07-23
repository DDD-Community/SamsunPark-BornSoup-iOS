//
//  MainView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    
    let store: StoreOf<Main>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Button {
                    viewStore.send(.fetchButtonTapped)
                } label: {
                    Text("Button")
                }
            }
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: Main.State(),
                reducer: {
                    Main()
                }
            )
        )
    }
}
