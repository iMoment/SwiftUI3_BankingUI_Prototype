//
//  HomeView.swift
//  BankingUI
//
//  Created by Stanley Pan on 2022/01/20.
//

import SwiftUI

struct HomeView: View {
    @State var colors: [ColorGrid] = [
        ColorGrid(hexValue: "15654B", color: Color("Green")),
        ColorGrid(hexValue: "DAA4FF", color: Color("Violet")),
        ColorGrid(hexValue: "FFD90A", color: Color("Yellow")),
        ColorGrid(hexValue: "FE9EC4", color: Color("Pink")),
        ColorGrid(hexValue: "FB3272", color: Color("Orange")),
        ColorGrid(hexValue: "4460EE", color: Color("Blue")),
    ]
    
    var body: some View {
        VStack {
            TopRow()
        }
        .vTop()
        .hCenter()
        .background(Color("background"))
        .preferredColorScheme(.dark)
    }
    
    // MARK: Animated Credit Card
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TopRow: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(.white)
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("profileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}
