//
//  OZTextView.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

struct OZTextView: View {
    @State var text = ""
    var body: some View {
        VStack {
            TextEditor(text: $text)
        }
    }
}

struct OZTextView_Previews: PreviewProvider {
    static var previews: some View {
        OZTextView()
    }
}
