//
//  CalendarDateNumberView.swift
//  PresentationKit
//
//  Created by 고병학 on 2023/09/03.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI

public enum DateNumberType {
    case _default
    case hasContent
    case today
    case anotherMonth
    
    var backgroundColor: Color {
        switch self {
        case ._default:
            return .orangeGray9
        case .hasContent:
            return .orangeGray9
        case .today:
            return .main1
        case .anotherMonth:
            return .orangeGray9
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case ._default:
            return .orangeGray3
        case .hasContent:
            return .main1
        case .today:
            return .white
        case .anotherMonth:
            return .orangeGray5
        }
    }
}

public struct CalendarDateNumberView: View {
    private enum Constants {
        enum Sizes {
            static let fullRadius: CGFloat = 100
        }
    }
    
    public init(
        dateNumber: Int,
        dateType: DateNumberType = ._default
    ) {
        self.dateNumber = dateNumber
        self.dateType = dateType
    }
    
    public var dateNumber: Int
    public var dateType: DateNumberType
    
    public var body: some View {
        Text("\(dateNumber)")
            .font(.Body3.semiBold)
            .foregroundColor(dateType.foregroundColor)
            .frame(width: 20, height: 20, alignment: .center)
            .background(dateType.backgroundColor)
            .cornerRadius(Constants.Sizes.fullRadius)
    }
}

#if DEBUG
struct CalendarDateNumberView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                CalendarDateNumberView(dateNumber: 1)
                CalendarDateNumberView(dateNumber: 13)
                CalendarDateNumberView(
                    dateNumber: 1,
                    dateType: .anotherMonth
                )
                CalendarDateNumberView(
                    dateNumber: 13,
                    dateType: .anotherMonth
                )
            }
            HStack {
                CalendarDateNumberView(
                    dateNumber: 1,
                    dateType: .hasContent
                )
                CalendarDateNumberView(
                    dateNumber: 13,
                    dateType: .hasContent
                )
                CalendarDateNumberView(
                    dateNumber: 1,
                    dateType: .today
                )
                CalendarDateNumberView(
                    dateNumber: 13,
                    dateType: .today
                )
            }
        }
    }
}
#endif
