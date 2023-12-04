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
    @State var score: Int = 2
    
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
                switch score {
                case 1:
                    DesignSystemKitAsset.icScoreFace1.swiftUIImage
                        .frame(width: 30, height: 30)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))
                case 2:
                    DesignSystemKitAsset.icScoreFace2.swiftUIImage
                        .frame(width: 30, height: 30)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))
                case 3:
                    DesignSystemKitAsset.icScoreFace3.swiftUIImage
                        .frame(width: 30, height: 30)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))
                case 4:
                    DesignSystemKitAsset.icScoreFace4.swiftUIImage
                        .frame(width: 30, height: 30)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))
                default:
                    DesignSystemKitAsset.icScoreFace0.swiftUIImage
                        .frame(width: 30, height: 30)
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 14))
                }

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
                                    maxWidth: score == 0 ? 0 : geometry.size.width * (CGFloat(score) / 4) + 12,
                                    alignment: .leading
                                )
                                .cornerRadius(100)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 16, alignment: .leading)
                        
                        HStack(alignment: .center) {
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .opacity(0.001)
                                    .onTapGesture {
                                        print("1점")
                                        self.score = 0
                                    }
                                
                                Circle()
                                    .fill(Color.orangeGray7)
                                    .frame(width: 8, height: 8)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 8, height: 8)
                                   
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .opacity(0.001)
                                    .onTapGesture {
                                        self.score = 1
                                    }
                                
                                Circle()
                                    .fill(Color.orangeGray7)
                                    .frame(width: 8, height: 8)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 8, height: 8)
                            
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .opacity(0.001)
                                    .onTapGesture {
                                        self.score = 2
                                    }
                                
                                Circle()
                                    .fill(Color.orangeGray7)
                                    .frame(width: 8, height: 8)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 8, height: 8)
                            
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .opacity(0.001)
                                    .onTapGesture {
                                        self.score = 3
                                    }
                                
                                Circle()
                                    .fill(Color.orangeGray7)
                                    .frame(width: 8, height: 8)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 8, height: 8)
                            
                            Spacer()
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .opacity(0.001)
                                    .onTapGesture {
                                        self.score = 4
                                    }
                                
                                Circle()
                                    .fill(Color.orangeGray7)
                                    .frame(width: 8, height: 8)
                                    .contentShape(Rectangle())
                            }
                            .frame(width: 8, height: 8)
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
