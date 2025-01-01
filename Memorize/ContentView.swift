//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2024-12-30.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🕷️","😈","💀", "💩", "👹", "🤡", "🖕🏽", "😻", "👅"]
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View{
        HStack{
            cardAdder
            Spacer()
            cardRemover
            
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View{
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View{
        return cardCountAdjuster(by: +1, symbol:"rectangle.stack.badge.plus.fill")
    }
}


struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = true
    @State private var dragOffset: CGSize = .zero
    @State private var revealed: Bool = false
    
    
    var body: some View{
        ZStack {
                    let base = RoundedRectangle(cornerRadius: 12)
                    Group {
                        if revealed {
                            Text(content).font(.largeTitle)
                        } else {
                            base.fill(.white)
                            base.strokeBorder(lineWidth: 2)
                            Text(content).font(.largeTitle).opacity(isFaceUp ? 1 : 0)
                        }
                    }
                    .animation(.easeInOut, value: revealed)
                    
                    base.fill().opacity(isFaceUp ? 0 : 1)
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.width) > 100 {
                                withAnimation {
                                    revealed = true
                                }
                            } else {
                                withAnimation {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .offset(dragOffset)
                .onTapGesture {
                    withAnimation {
                        isFaceUp.toggle()
                    }
                }
    }
}

#Preview {
    ContentView()
}
