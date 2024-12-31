//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2024-12-30.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🕷️","😈","🎃"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) {index in
                CardView(content: emojis[index])

            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}


struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = true
    
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius:12)
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }else{
                base.fill()
            }
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
