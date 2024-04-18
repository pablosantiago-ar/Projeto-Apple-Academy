//
//  QuizQuestions.swift
//  quiz
//
//  Created by aluno on 14/06/22.
//

import SwiftUI

struct QuizQuestions: View {
    
    @State var i: Int = 0
    @State var z: Int = 0
    @State var score = 0
    @State var nPergunta: Int = 1
    @State private var showActionSheet = false
    var body: some View {
        ZStack{
            
            Color(red: 67/255, green: 151/255, blue: 117/255)
                .ignoresSafeArea()
            VStack {
                Text("QUIZ")
                    .font(.system(size:22))
                    .foregroundColor(.white)
                    .bold()
                    .shadow(color: .black, radius: 1, x: 3, y: 2)
                
                Text("Pontos: \(score)/7")
                    .font(.system(size:22))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 15) {
                    if(self.i < myQuiz1.count) {
                        //                Image(myQuiz1[self.i].img!)
                        //                    .resizable()
                        //                    .scaledToFit()
                        //                    .padding(.horizontal)
                        
                        Text("\(nPergunta). "+myQuiz1[self.i].text!)
                            .font(.system(size: 25))
                            .foregroundColor(Color(red: 67/255, green: 151/255, blue: 117/255))
                            .bold()
                            
                        Button(action: {
                            nPergunta += 1
                            self.showActionSheet = true
                            self.buttonAction(n: 0)
                        }, label: {
                            Text(myQuiz1[self.i].answer[0])
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                        })
                            .actionSheet(isPresented: $showActionSheet) {
                                ActionSheet(
                                    title: Text("Pontos"),
                                    message: Text("Score: \(self.score) / \(myQuiz1.count)"),
                                    buttons: [
                                       .cancel { print(self.showActionSheet)}

                                    ]
                                    
                                )
                            }
                        Button(action: {
                            nPergunta += 1
                            self.buttonAction(n: 1)
                            self.showActionSheet = true
                        }, label: {
                            Text(myQuiz1[self.i].answer[1])
                                .foregroundColor(.gray)
                                .font(.system(size: 20))
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 2))
                        })
                            .actionSheet(isPresented: $showActionSheet) {
                                ActionSheet(
                                    title: Text("Pontos"),
                                    message: Text("Score: \(self.score) / \(myQuiz1.count)"),
                                    buttons: [
                                        .cancel { print(self.showActionSheet)}
                                    ]
                                )
                            }
                    }
                    else {
                        FinalView(score: self.score)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                }
                .padding()
                .onAppear {
                    UITabBar.appearance().isTranslucent = false
                    UITabBar.appearance().isHidden = true
                }
                
                Spacer()
            }
        }
    }

    func buttonAction( n : Int) {
        if(myQuiz1[self.i].correct == n){
            self.score = self.score + 1
        }
        self.i = self.i + 1
    }
    
    
}



struct QuizQuestions_Previews: PreviewProvider {
    static var previews: some View {
        QuizQuestions()
    }
}

