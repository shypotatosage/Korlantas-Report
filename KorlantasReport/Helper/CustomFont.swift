//
//  CustomFont.swift
//  KorlantasReportIOS
//
//  Created by Marsha Likorawung  on 23/04/23.
//

import Foundation
import SwiftUI

struct CustomFont: ViewModifier {
    var textStyle: TextStyle

    var name: String {
        switch textStyle {
        case .largeTitle, .title, .title2, .title3:
            return "Poppins Bold"
        case .body, .footnote, .caption, .subheadline3:
            return "Poppins Regular"
        case .headline, .subheadline2, .footnote2, .caption2:
            return "Poppins Medium"
        case .subheadline, .subheadline4:
            return "Poppins SemiBold"
        }
    }

    var size: CGFloat {
        switch textStyle {
        case .largeTitle:
            return 30
        case .title:
            return 18
        case .title2:
            return 24
        case .title3:
            return 20
        case .body:
            return 18
        case .headline:
            return 18
        case .subheadline:
            return 18
        case .subheadline2:
            return 15
        case .subheadline3:
            return 15
        case .subheadline4:
            return 15
        case .footnote:
            return 13
        case .footnote2:
            return 13
        case .caption:
            return 12
        case .caption2:
            return 12
        }
    }

    var relative: Font.TextStyle {
        switch textStyle {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .body:
            return .body
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .subheadline2:
            return .subheadline
        case .subheadline3:
            return .subheadline
        case .subheadline4:
            return .subheadline
        case .footnote:
            return .footnote
        case .footnote2:
            return .footnote
        case .caption:
            return .caption
        case .caption2:
            return .caption
        }
    }

    func body(content: Content) -> some View {
        content.font(.custom(name, size: size, relativeTo: relative))
    }
}

extension View {
    func customFont(_ textStyle: TextStyle) -> some View {
        modifier(CustomFont(textStyle: textStyle))
    }
}

enum TextStyle {
    case largeTitle
    case title
    case title2
    case title3
    case body
    case headline
    case subheadline
    case subheadline2
    case subheadline3
    case subheadline4
    case footnote
    case footnote2
    case caption
    case caption2
}
