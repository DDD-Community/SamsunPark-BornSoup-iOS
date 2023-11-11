//
//  WrappingHStack.swift
//  PresentationKit
//
//  Created by 고병학 on 11/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

// Adapted from: 
// https://stackoverflow.com/questions/62102647/swiftui-hstack-with-wrap-and-dynamic-height/62103264#62103264
public struct WrappingHStack<Model, V>: View where Model: Hashable, V: View {
    public typealias ViewGenerator = (Model) -> V
    
    public var models: [Model]
    public var viewGenerator: ViewGenerator
    public var horizontalSpacing: CGFloat = 2
    public var verticalSpacing: CGFloat = 0
    
    public init(models: [Model], viewGenerator: @escaping ViewGenerator, horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        self.models = models
        self.viewGenerator = viewGenerator
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.totalHeight = totalHeight
}

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        // .frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.models, id: \.self) { models in
                viewGenerator(models)
                    .padding(.horizontal, horizontalSpacing)
                    .padding(.vertical, verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if models == self.models.last! {
                            width = 0 // last item
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if models == self.models.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
