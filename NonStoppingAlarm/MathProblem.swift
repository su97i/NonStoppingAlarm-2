//
//  MathProblem.swift
//  NonStoppingAlarm
//
//  Created by Sarah Sheikh on 9/01/2023.
//

import SwiftUI

struct MathProblem: View {
    @State private var correctAnswer = 0
    @State private var choiceArray : [Int] = [0, 1, 2, 3]
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var difficulty = 200
    @State private var score = 0
    @State private var stop = false
    
    
    
    var body: some View {
        VStack{
            Text("Solve Maths Problem")
                .font(.largeTitle)
                .padding(.bottom, 50)
                .accessibility(hint:  Text("Solve Maths Problem"))
            
            
            VStack {
                Text("\(firstNumber) + \(secondNumber)")
                    .font(.largeTitle)
                    .bold()
                
                
                HStack {
                    ForEach(0..<2) {index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label: {
                            Answer(number: choiceArray[index])
                        }
                    }
                }
                
                HStack {
                    ForEach(2..<4) {index in
                        Button {
                            answerIsCorrect(answer: choiceArray[index])
                            generateAnswers()
                        } label: {
                            Answer(number: choiceArray[index])
                        }
                    }
                }
                Text("Score: \(score)")
                    .font(.headline)
                    .bold()
            }.onAppear(perform: generateAnswers)
            
        }
        
        
        .sheet(isPresented: $stop) {
            DoneView()
        }
        
        
    }
    
    func answerIsCorrect(answer: Int){
        
        if  score == 5 {
            stop = true
        }
        else if answer == correctAnswer {
            self.score += 1
        }
        else {
            //                    self.score -= 1
        }
    }
    
    
    func generateAnswers(){
        firstNumber = Int.random(in: 0...(difficulty/2))
        secondNumber = Int.random(in: 0...(difficulty/2))
        var answerList = [Int]()
        
        correctAnswer = firstNumber + secondNumber
        
        for _ in 0...2 {
            answerList.append(Int.random(in: 0...difficulty))
        }
        
        answerList.append(correctAnswer)
        
        choiceArray = answerList.shuffled()
    }
}




struct MathProblem_Previews: PreviewProvider {
    static var previews: some View {
        MathProblem()
    }
}
