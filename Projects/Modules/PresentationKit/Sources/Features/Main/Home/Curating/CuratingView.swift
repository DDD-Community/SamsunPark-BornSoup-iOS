//
//  CuratingView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/30.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture

import SwiftUI
import DesignSystemKit

public struct CuratingView: View {
    let store: StoreOf<Curating>
    @State var currentIndex = 0
    @GestureState var dragOffset: CGFloat = 0
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                ZStack {
                    
                    ForEach(
                        Array(zip(viewStore.contentsList.indices, viewStore.contentsList)),
                        id: \.0
                    ) { index, contents in
                        VStack {
                            Text(contents.title)
                        }
                        .frame(width: 310, height: 500)
                        .background(Color.red)
                        .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            print(value.translation.width / 100)
                        })
                        .onEnded({ value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                }
                            } else if value.translation.width < -threshold {
                                withAnimation {
                                    currentIndex = min(viewStore.contentsList.count - 1, currentIndex + 1)
                                }
                            }
                        })
                )
            }
        }
    }
}

#if DEBUG
struct Curating_PreView: PreviewProvider {
    static var previews: some View {
        CuratingView(
            store: Store(
                initialState: Curating.State(contentsList: []),
                reducer: {
                    Curating()
                }
            )
        )
    }
}
#endif
