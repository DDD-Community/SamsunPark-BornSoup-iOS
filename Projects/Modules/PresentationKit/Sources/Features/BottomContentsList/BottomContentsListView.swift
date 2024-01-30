//
//  BottomContentsList.swift
//  PresentationKit
//
//  Created by 신의연 on 12/10/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import Kingfisher

import SwiftUI

struct BottomContentsListView: View {
    @State private var height: CGFloat = 0
    var body: some View {
        ScrollView {
            Text("한양여성 문 밖을 나서다")
            HStack {
                Text("고궁")
                Divider()
                    .frame(height: 12)
                Text("서울, 종로구")
                Divider()
                    .frame(height: 12)
                Text("2023.4.13 ~ 6.4")
            }
            ScrollView(.horizontal) {
                HStack {
                    
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            height = proxy.size.height
                        }
                })
            .background(Color.white)
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width, height: height)
        }
    }
}

#Preview {
    ZStack {
        Text("hi")
        BottomContentsListView()
            .transition(.move(edge: .bottom))
        
    }
}
