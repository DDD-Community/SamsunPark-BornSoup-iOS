//
//  Font+.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/08/26.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public extension Font {
    
    enum Size {
        static let head0: CGFloat = 34
        static let head1: CGFloat = 28
        static let head2: CGFloat = 22
        static let title1: CGFloat = 20
        static let title2: CGFloat = 18
        static let body1: CGFloat = 16
        static let body2: CGFloat = 14
        static let body3: CGFloat = 12
    }
    
    typealias Pretendard = DesignSystemKitFontFamily.Pretendard
    
    enum Head0 {
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: Font.Size.head0)
    }
    
    enum Head1 {
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 28)
    }
    
    enum Head2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 22)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 22)
    }
    
    enum Title1 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 20)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 20)
    }
    
    enum Title2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 18)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 18)
    }
    
    enum Body1 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 16)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 16)
    }
    
    enum Body2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 14)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 14)
    }
    
    enum Body3 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 12)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 12)
    }
}
