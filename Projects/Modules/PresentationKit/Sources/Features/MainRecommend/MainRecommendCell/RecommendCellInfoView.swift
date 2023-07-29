//
//  RecommendCellInfoView.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct RecommendCellInfoView: View {
    let title: String
    let date: String
    let place: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 34, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            HStack {
                Text("\(date) | \(place)")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }
        }
    }
}
