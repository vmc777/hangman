//
//  HangmanView.swift (ContentView.swift)
//  hangman (app name)
//
//  Created by VerDel Cargal on 9/21/22.
//

import SwiftUI

struct HangmanView: View {
    @StateObject var viewModel = HangmanViewModel()

    var body: some View {
        ZStack {
            GameView(viewModel: viewModel)
            if viewModel.status == .won {
                WonView(viewModel: viewModel)
            }
            if viewModel.status == .lost {
                LostView(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Theme.backgroundColor)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HangmanView()
    }
}
