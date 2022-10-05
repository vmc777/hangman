//
//  TitlePage.swift
//  hangman
//
//  Created by Mike and VerDel Cargal on 10/1/22.
//

import SwiftUI

struct TitlePage: View {
    
    
    var body: some View {
        VStack {
            Text("Hangman!")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .bold()
                .padding()
            HStack {
                
            }
        }
        
        .frame(width: 350, height: 600, alignment: .top)
        
        Text("Play Game")
            .foregroundColor(.green)
            .background(.yellow)
            .buttonBorderShape(ButtonBorderShape.capsule)
    }
}

struct TitlePage_Previews: PreviewProvider {
    static var previews: some View {
        TitlePage()
    }
}
