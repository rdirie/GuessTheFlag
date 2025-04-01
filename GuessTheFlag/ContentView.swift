//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rayyan Dirie on 3/25/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var resetScore = false
    @State private var scoreTitle = ""
    @State private var resetBanner = "| Game Over |"
    @State private var pointScore = 0
    @State private var questionNumber = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in:0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the Flag Of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(pointScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                Spacer()
                
                Text("Question: \(questionNumber)/8")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(pointScore)")
        }
        
        .alert(resetBanner, isPresented: $resetScore) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(pointScore)!")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            pointScore += 1
        }
        else{
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        if (questionNumber == 8){
            resetScore = true
        }
        else{
            questionNumber += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func reset(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        pointScore = 0
        questionNumber = 1
    }

}

#Preview {
    ContentView()
}
