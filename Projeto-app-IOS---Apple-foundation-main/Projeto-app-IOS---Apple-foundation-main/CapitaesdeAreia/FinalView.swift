//
//  FinalView.swift
//  quiz
//
//  Created by aluno on 14/06/22.
//

import SwiftUI

struct FinalView: View {
    var score: Int
    var body: some View {
        VStack{
            Text("Pontos finais: \(score)")
                .onAppear(){
                    SaveScore(quiz: "myQuiz1", score: self.score)
                    
                }
        }
    }
}

struct FinalView_Previews: PreviewProvider {
    static var previews: some View {
        FinalView(score: 1)
    }
}

