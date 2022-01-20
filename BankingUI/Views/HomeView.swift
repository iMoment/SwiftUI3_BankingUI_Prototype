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
    
    // MARK: Animation Properties
    @State var animations: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        VStack {
            TopRow()
            
            CreditCard()
            
            HStack {
                Text("Choose a color")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hLeading()
                
                Button {
                    
                } label: {
                    Text("View all")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Pink"))
                        .underline()
                }
            }
            .padding()
            
            Color.black
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                .padding(.top)
        }
        .vTop()
        .hCenter()
        .ignoresSafeArea(.container, edges: .bottom)
        .background(Color("background"))
        .preferredColorScheme(.dark)
        .onAppear(perform: animateScreen)
    }
    
    func animateScreen() {
        
    }
    
    // MARK: Animated Credit Card
    @ViewBuilder
    func CreditCard() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("Pink"))
            
            VStack {
                HStack {
                    ForEach(1...4, id: \.self) { _ in
                        Circle()
                            .fill(Color.white)
                            .frame(width: 6, height: 6)
                    }
                    
                    Text("3764")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .hLeading()
                
                HStack(spacing: -12) {
                    Text("Homer Simpson")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .hLeading()
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .stroke(Color.white, lineWidth: 1)
                        .frame(width: 30, height: 30)
                }
                .vBottom()
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .vTop()
            .hLeading()
            
            // MARK: Top Ring
            Circle()
                .stroke(Color.white.opacity(0.5), lineWidth: 18)
                .offset(x: 130, y: -120)
        }
        .clipped()
        .frame(height: 250)
        .padding()
    }
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
        .padding([.horizontal, .top])
        .padding(.bottom, 5)
    }
}
