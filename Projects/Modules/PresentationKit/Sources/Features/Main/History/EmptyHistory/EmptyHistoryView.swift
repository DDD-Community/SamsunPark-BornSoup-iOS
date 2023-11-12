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
            VStack {
                Spacer()
                
                Text("첫 기록을 남겨보세요!")
                  .font(Font.Head2.semiBold)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color.orangeGray1)
                  .padding(.bottom, 36)
                
                ZStack {
                    DesignSystemKitAsset.icSun360.swiftUIImage
                        .resizable()
                        .frame(
                            width: viewStore.state.isSunBig ? 1200 : 360,
                            height: viewStore.state.isSunBig ? 1200 : 360
                        )
                        .padding(.bottom, viewStore.state.isSunBig ? 100 : -220)
                    
                    if !viewStore.state.isSunBig {
                        DesignSystemKitAsset.icPlusWhite.swiftUIImage
                            .frame(width: 24, height: 24)
                            .padding(.top, -60)
                    }
                }
                .animation(.easeIn, value: viewStore.state.isSunBig)
                .onTapGesture {
                    viewStore.send(.didTapAddHistory)
                }
                .onDisappear {
                    viewStore.send(.onDisappear)
                }
            }
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
