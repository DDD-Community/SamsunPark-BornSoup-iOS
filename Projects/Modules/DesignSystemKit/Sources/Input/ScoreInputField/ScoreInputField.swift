//
//  ScoreInputField.swift
//  DesignSystemKit
//
//  Created by 고병학 on 11/12/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public struct ScoreInputField: View {
    public init(title: String, isNecessaryField: Bool) {
        self.title = title
        self.isNecessaryField = isNecessaryField
    }
    
    private let title: String
    private let isNecessaryField: Bool
    private var score: Double = 1
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if isNecessaryField {
                Text(title)
                    .font(Font.Body1.regular)
                    .foregroundColor(Color.orangeGray1)
                + Text("*")
                    .font(Font.Body1.regular)
                    .foregroundColor(Color.red)
            } else {
                Text(title)
                    .font(Font.Body1.regular)
                    .foregroundColor(Color.orangeGray1)
            }
            
            HStack(alignment: .center) {
                DesignSystemKitAsset.icScoreFace0.swiftUIImage
                    .frame(width: 30, height: 30)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))

                ZStack {
                    GeometryReader { geometry in
                        HStack(alignment: .center) {
                            Rectangle()
                                .fill(LinearGradient(
                                    stops: [
                                        Gradient.Stop(color: Color(red: 1, green: 0.56, blue: 0), location: 0.00),
                                        Gradient.Stop(color: Color(red: 1, green: 0.9, blue: 0.5), location: 1.00)
                                    ],
                                    startPoint: UnitPoint(x: 1, y: 0.5),
                                    endPoint: UnitPoint(x: 0, y: 0.5)
                                ))
                                .frame(
                                    maxWidth: score == 0 ? 0 : geometry.size.width * (score / 4) + 12,
                                    alignment: .leading
                                )
                                .cornerRadius(100)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 16, alignment: .leading)
                        
                        HStack(alignment: .center) {
                            Circle()
                                .fill(Color.orangeGray7)
                                .frame(width: 8, height: 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("1점")
                                }
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.orangeGray7)
                                .frame(width: 8, height: 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("2점")
                                }
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.orangeGray7)
                                .frame(width: 8, height: 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("3점")
                                }
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.orangeGray7)
                                .frame(width: 8, height: 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("4점")
                                }
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color.orangeGray7)
                                .frame(width: 8, height: 8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    print("5점")
                                }
                        }
                        .padding(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(100)
                    }
                    .frame(height: 16)
                }
            }
            .padding(0)
            .frame(width: 337, height: 30, alignment: .center)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.orangeGray9)
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ScoreInputField_Previews: PreviewProvider {
    static var previews: some View {
        ScoreInputField(title: "만족도", isNecessaryField: true)
    }
}
#endif
