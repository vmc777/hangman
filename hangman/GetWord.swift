//
//  GetWord.swift
//  hangman
//
//  Created by VerDel Cargal on 10/1/22.
//

import SwiftUI

struct GetWord: View {
    var body: some View {
        let asset = NSDataAsset(name: "word-list-raw")
        let _ = asset?.data.randomElement()
    }
}

struct GetWord_Previews: PreviewProvider {
    static var previews: some View {
        GetWord()
    }
}
