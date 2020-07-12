//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gavin Butler on 11-07-2020.
//  Copyright © 2020 Gavin Butler. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scissors"]
    let colours: [Color] = [.red, .blue, .black]
    var modes = ["Win", "Lose"]
    let winCombinations = [1, 2, 0]
    let loseCombinations = [2, 0, 1]
    
    @State private var appChoice: Int = Int.random(in: 0..<3)
    @State private var forTheWin = Bool.random()
    
    @State private var score = 0
    @State private var modeChoice = 0
    
    @State private var playAgainButtonDisabled = true
    
    @State private var roundEndMessage = " "
    
    private let debug = false
    private let enabledButtonColor = Color(red: 64/255, green: 64/255, blue: 64/255)
    private let disabledButtonColor = Color(red: 100/255, green: 100/255, blue: 100/255)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.yellow]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                Picker("Select to win or lose", selection: $modeChoice) {
                    ForEach(0..<modes.count) {
                        Text(self.modes[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                VStack(spacing: 30) {
                    ForEach(0..<moves.count) { index in
                        Button(self.moves[index]) {
                            self.processScore(with: index)
                            self.playAgainButtonDisabled.toggle()
                        }
                        .disabled(!self.playAgainButtonDisabled)
                        .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 50)
                        .foregroundColor(.white)
                        .font(.title)
                        .background(self.playAgainButtonDisabled ? self.enabledButtonColor : self.disabledButtonColor)
                        .clipShape(Capsule(style: .circular))
                    }
                }
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .padding(30)
                VStack(spacing: 6) {
                    Text("App's Selection: \(moves[appChoice])")
                    Text("PlayerModeChoice: \(modes[modeChoice])")
                }
                .opacity(debug ? 1 : 0)
                Text(roundEndMessage)
                    .font(.largeTitle)
                Button("Play Again?") {
                    self.appChoice = Int.random(in: 0..<3)
                    self.playAgainButtonDisabled = true
                    self.roundEndMessage = " "
                }
                .disabled(playAgainButtonDisabled)
                .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 50)
                .foregroundColor(playAgainButtonDisabled ? .gray : .white)
                .font(.title)
                .background(playAgainButtonDisabled ? Color(red: 204/255, green: 204/255, blue: 204/255) : colours[2])
                .clipShape(Capsule(style: .circular))
            }
        }
    }
    
    func processScore(with playerChoice: Int) {
        let winningCombinations = modeChoice == 0 ? winCombinations : loseCombinations
        
        if playerChoice == winningCombinations[appChoice] {
            roundEndMessage = "YOU WON!!"
            score += 1
        } else {
            roundEndMessage = "YOU LOST!!"
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
