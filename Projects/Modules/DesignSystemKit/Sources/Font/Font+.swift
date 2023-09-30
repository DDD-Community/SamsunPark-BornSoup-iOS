//
//  Font+.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/08/26.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

extension Font {
    
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
    
    public enum Head0 {
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: Font.Size.head0)
    }
    
    public enum Head1 {
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 28)
    }
    
    public enum Head2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 22)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 22)
    }
    
    public enum Title1 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 20)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 20)
    }
    
    public enum Title2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 18)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 18)
    }
    
    public enum Body1 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 16)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 16)
    }
    
    public enum Body2 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 14)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 14)
    }
    
    public enum Body3 {
        public static let regular: Font = Pretendard.regular.swiftUIFont(size: 12)
        public static let semiBold: Font = Pretendard.semiBold.swiftUIFont(size: 12)
    }
}
