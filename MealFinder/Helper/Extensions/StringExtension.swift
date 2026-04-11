//
//  StringExtension.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import Foundation
import UIKit

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
         let fontAttributes = [NSAttributedString.Key.font: font]
         let size = self.size(withAttributes: fontAttributes)
         return size.width
     }
    
}
