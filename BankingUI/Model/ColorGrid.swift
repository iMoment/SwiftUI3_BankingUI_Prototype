//
//  ColorGrid.swift
//  BankingUI
//
//  Created by Stanley Pan on 2022/01/20.
//

import SwiftUI

struct ColorGrid: Identifiable {
    var id: String = UUID().uuidString
    var hexValue: String
    var color: Color
    
    // MARK: Animation Properties for Card
    var rotateCards: Bool = false
    var addToGrid: Bool = false
    var showText: Bool = false
    var removeFromView: Bool = false
}
