//
//  Extensions.swift
//  BankingUI
//
//  Created by Stanley Pan on 2022/01/20.
//

import SwiftUI

// MARK: Making UI Design faster
extension View {
    
    func hLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func hTrailing() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    func hCenter() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func vCenter() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    
    func vTop() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func vBottom() -> some View {
        self
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
