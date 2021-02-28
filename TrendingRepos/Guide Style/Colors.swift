//
//  Colors.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)

        // swiftlint:disable identifier_name
        let a, r, g, b: UInt32
        // swiftlint:enable identifier_name
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

enum Colors: String {
    case red = "#FC644B"
    case orange = "#F48026"
    case darkGrey = "#4B5D72"
    case blue = "#222A38"
}

extension Colors {
    var color: UIColor {
        UIColor(hex: self.rawValue)
    }
}
