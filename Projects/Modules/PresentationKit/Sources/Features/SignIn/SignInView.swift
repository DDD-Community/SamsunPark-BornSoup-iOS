//
//  SignInView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/07/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SignInView: View {
    
    let store: StoreOf<SignIn>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: SignIn.Action.path)) {
            Section {
                Button {
                    // social login
                } label: {
                    NavigationLink(
                        "continue with kakao",
                        state: SignIn.Path.State.termAgreement()
                    )
                }
            }
            .navigationTitle("Root")
        } destination: { initialState in
            TermAgreementView()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(store: StoreOf<SignIn>(initialState: SignIn.State(), reducer: {
            SignIn()
        }))
    }
}
