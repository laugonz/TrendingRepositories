//
//  NSAttributedString+Links.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

extension NSMutableAttributedString {
    func setLink(textToFind: String, linkURL: String) {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: URL(string: linkURL)!, range: foundRange)
            self.addAttribute(NSAttributedString.Key.underlineStyle,
                              value: NSUnderlineStyle.single.rawValue,
                              range: foundRange)
        }
    }

    func underline(_ textToFind: String) {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.underlineStyle,
                              value: NSUnderlineStyle.single.rawValue,
                              range: foundRange)
        }
    }
}
