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
    
    // MatchedGeometry Namespace
    @Namespace var animation
    
    @State var selectedColor: Color = Color("Pink")
    
    var body: some View {
        VStack {
            TopRow()
            
            
            GeometryReader { proxy in
                let maxY = proxy.frame(in: .global).maxY
                
                CreditCard()
                    .rotation3DEffect(.init(degrees: animations[0] ? 0 : -270), axis: (x: 1, y: 0, z: 0), anchor: .center)
                    .offset(y: animations[0] ? 0 : -maxY)
                    
            }
            .frame(height: 250)
            
            HStack {
                Text("Choose a color")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .hLeading()
                    .offset(x: animations[1] ? 0 : -200)
                
                Button {
                    
                } label: {
                    Text("View all")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Pink"))
                        .underline()
                }
                .offset(x: animations[1] ? 0 : 200)
            }
            .padding()
            
            GeometryReader { proxy in
//                let size = proxy.size
                ZStack {
                    Color.black
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 40))
                        .frame(height: animations[2] ? nil : 0)
                        .vBottom()
                    
                    ZStack {
                        // MARK: Initial Grid View
                        ForEach(colors) { colorGrid in
                            
                            if !colorGrid.removeFromView {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorGrid.color)
                                    .frame(width: 150, height: animations[3] ? 60 : 150)
                                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
                                    .rotationEffect(.init(degrees: colorGrid.rotateCards ? 180 : 0))
                            }
                        }
                    }
                    // MARK: Opacity w/ Scale Animation
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background"))
                            .frame(width: 150, height: animations[3] ? 60 : 150)
                            .opacity(animations[3] ? 0 : 1)
                    )
                    .scaleEffect(animations[3] ? 1 : 2.3)
                }
                .hCenter()
                .vCenter()
                
                // MARK: ScrollView with Color Grids
                ScrollView(.vertical, showsIndicators: false) {
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(colors) { colorGrid in
                            
                            GridCardView(colorGrid: colorGrid)
                        }
                    }
                    .padding(.top, 40)
                }
                .cornerRadius(40)
            }
            .padding(.top)
        }
        .vTop()
        .hCenter()
        .ignoresSafeArea(.container, edges: .bottom)
        .background(Color("background"))
        .preferredColorScheme(.dark)
        .onAppear(perform: animateScreen)
    }
    
    // MARK: Grid Card View
    @ViewBuilder
    func GridCardView(colorGrid: ColorGrid) -> some View {
        VStack {
            if colorGrid.addToGrid {
                // Displaying with Matched Geometry Effect
                RoundedRectangle(cornerRadius: 10)
                    .fill(colorGrid.color)
                    .frame(width: 150, height: 60)
                    .matchedGeometryEffect(id: colorGrid.id, in: animation)
                    .onAppear {
                        if let index = colors.firstIndex(where: { color in
                            return color.id == colorGrid.id
                        }) {
                            withAnimation {
                                colors[index].showText = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    colors[index].removeFromView = true
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            selectedColor = colorGrid.color
                        }
                    }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .frame(width: 150, height: 60)
            }
            
            Text(colorGrid.hexValue)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(Color.white)
                .hLeading()
                .padding([.horizontal, .top])
                .opacity(colorGrid.showText ? 1 : 0)
        }
    }
    
    func animateScreen() {
        // Flipping card
        withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
            animations[0] = true
        }
        
        // Side text
        withAnimation(.easeInOut(duration: 0.7)) {
            animations[1] = true
        }
        
        // Bottom container slide up
        withAnimation(.interactiveSpring(response: 1.3, dampingFraction: 0.7, blendDuration: 0.7).delay(0.2)) {
            animations[2] = true
        }
        
        withAnimation(.easeInOut(duration: 0.8)) {
            animations[3] = true
        }
        
        // Final Grid Forming Animation
        for index in colors.indices {
            let delay: Double = (0.9 + (Double(index) * 0.1))
            let backIndex = ((colors.count - 1) - index)
            
            withAnimation(.easeInOut.delay(delay)) {
                colors[backIndex].rotateCards = true
            }
            
            // .delay() will not work on if...else, use DispatchQueue delay
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation {
                    colors[backIndex].addToGrid = true
                }
            }
        }
    }
    
    
    // MARK: Animated Credit Card
    @ViewBuilder
    func CreditCard() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedColor)
            
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
