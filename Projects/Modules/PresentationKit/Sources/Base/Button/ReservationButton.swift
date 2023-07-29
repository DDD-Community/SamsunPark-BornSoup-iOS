//
//  ReservationButton.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/07/29.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct ReservationButton: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("예약하기")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding(12)
        .frame(width: 94, height: 36, alignment: .center)
        .background(.white)
        .cornerRadius(4)
    }
}
