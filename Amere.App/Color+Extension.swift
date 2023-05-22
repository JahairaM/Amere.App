//
//  RingBackend1.swift
//  Amere.App
//
//  Created by Jahaira Maxwell-Myers on 5/22/23.
//

import Foundation
import SwiftUI

/// Creating color extensions to plug in custom colors for the rings.
extension Color {
    public static var outlineBlue: Color {
        return Color(decimalBlue: 37, green: 150, blue: 250
        ).opacity(0.3)
    }
    
    public static var darkBlue: Color {
        return Color(decimalBlue: 37, green: 150, blue: 250)
    }
    
    public static var lightBlue: Color {
        return Color(decimalBlue: 37, green: 150, blue: 250)
    }
    
    
    
    public static var outlineGreen: Color {
        return Color(decimalBlue: 90, green: 168, blue: 44).opacity(0.3)
    }
    public static var darkGreen: Color {
        return Color(decimalBlue: 90, green: 168, blue: 44)
    }
    public static var lightGreen: Color {
        return Color(decimalBlue: 90, green: 168, blue: 44)
    }
    
    
    
    public static var outlineYellow: Color {
        return Color(decimalBlue: 255, green: 173, blue: 2).opacity(0.3)
            
        }
        public static var darkYellow: Color {
            return Color(decimalBlue: 255, green: 173, blue: 2)
        }
    public static var lightYellow: Color {
        return Color(decimalBlue: 255, green: 173, blue: 2)
    }
    
    
    
    public init(decimalBlue red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}
