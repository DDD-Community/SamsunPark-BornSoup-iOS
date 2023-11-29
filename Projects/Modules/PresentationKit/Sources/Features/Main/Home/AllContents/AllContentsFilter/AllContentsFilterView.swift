//
//  AllContentsFilterView.swift
//  PresentationKit
//
//  Created by 신의연 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import ComposableArchitecture
import DesignSystemKit
import DomainKit
import SwiftUI

public struct AllContentsFilterView: View {
    let store: StoreOf<AllContentsFilter>
    
    public init(store: StoreOf<AllContentsFilter>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                Text(Constants.title)
                    .font(.Title2.semiBold)
                    .foregroundColor(.orangeGray1)
                    .padding(.top, 30)
                List {
                    ForEach(viewStore.filterList, id: \.self) { filter in
                        HStack {
                            Text(filter.contentsType.rawValue)
                                .font(.Title2.regular)
                            Spacer()
                            DesignSystemKitAsset.icChange24.swiftUIImage
                        }
                    }
                    .onMove { viewStore.send(.move($0, $1)) }
                }
                .padding(.bottom, 16)
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                
                PrimaryButton(title: "확인") {
                    viewStore.send(.confirmButtonTapped)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
            .presentationDetents([.height(500)])
        }
    }
}

#Preview {
    AllContentsFilterView(
        store: Store(
            initialState: AllContentsFilter.State(),
            reducer: {
                AllContentsFilter()
            }
        )
    )
}

extension AllContentsFilterView {
    enum Constants {
        static let title = "순서 변경"
    }
}
