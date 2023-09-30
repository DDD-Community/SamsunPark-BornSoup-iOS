//
//  Color+.swift
//  PresentationKit
//
//  Created by 신의연 on 2023/08/26.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

extension Color {
    public static let main1 = Color(hex: 0xFF8F00, opacity: 1)
    public static let main2 = Color(hex: 0xFFB111, opacity: 1)
    public static let main3 = Color(hex: 0xFFD740, opacity: 1)
    public static let main4 = Color(hex: 0xFFE57F, opacity: 1)
    public static let main5 = Color(hex: 0xFFECB3, opacity: 1)
    public static let main6 = Color(hex: 0xFFF8E1, opacity: 1)
    
    public static let ozWhite = Color(hex: 0xFFFFFF, opacity: 1)
    public static let mainLinear = Color(hex: 0xFF8F00, opacity: 1).gradient
    
    public static let error = Color(hex: 0xF10000, opacity: 1)
    
    public static let orangeGray1 = Color(hex: 0x302D29, opacity: 1)
    public static let orangeGray2 = Color(hex: 0x534F4B, opacity: 1)
    public static let orangeGray3 = Color(hex: 0x736F6A, opacity: 1)
    public static let orangeGray4 = Color(hex: 0x88847F, opacity: 1)
    public static let orangeGray5 = Color(hex: 0xB2AEA9, opacity: 1)
    public static let orangeGray6 = Color(hex: 0xD0CBC6, opacity: 1)
    public static let orangeGray7 = Color(hex: 0xF1EDE8, opacity: 1)
    public static let orangeGray8 = Color(hex: 0xF6F2ED, opacity: 1)
    public static let orangeGray9 = Color(hex: 0xFBF7F2, opacity: 1)
    public static let orangeGray10 = Color(hex: 0xFFFCF6, opacity: 1)
    
    public init(hex: Int, opacity: Double = 1.0) {
        let red = Double((Int(hex) >> 16) & 0xff) / 255
        let green = Double((Int(hex) >> 8) & 0xff) / 255
        let blue = Double((Int(hex) >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
