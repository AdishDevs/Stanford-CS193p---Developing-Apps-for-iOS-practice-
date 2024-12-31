//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 2024-12-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}


struct CardView: View{
    @State var isFaceUp: Bool = false
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius:12)
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
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
