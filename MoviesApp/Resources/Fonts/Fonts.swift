//
//  Fonts.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//

import Foundation
import UIKit


protocol FontRepresentable {
    var name: String { get }
    func sized(_ size: CGFloat) -> UIFont
}

extension FontRepresentable {
    func sized(_ size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
}




enum Fonts {

    enum SwanSea : FontRepresentable {
        case regular, bold, boldItalic, italic
        var name: String {
            switch self {
            case .regular:
                return "Swansea"
            case .bold:
                return "SwanseaBold"
            case .boldItalic:
                return "SwanseaBoldItalic"
            case .italic:
                return "SwanseaItalic"
           
            }
        }
    }
 
}


extension UIFont {
    
    static func printAllFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
    

}

