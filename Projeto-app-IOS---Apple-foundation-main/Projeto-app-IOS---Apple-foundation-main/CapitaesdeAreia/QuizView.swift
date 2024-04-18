//
//  QuizView.swift
//  CapitaesdeAreia
//
//  Created by aluno on 14/06/22.
//

import SwiftUI

struct QuizView: View {
    
    @Binding var score: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(red: 67/255, green: 151/255, blue: 117/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 20){
                    Image("fotoLogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                    
                    
                    Text(" Bem-vindo ao quiz \nDESMORONA BRASIL")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .bold()
                    
                    NavigationLink(destination: QuizQuestions()){
                        Text("Iniciar")
                            .font(.system(size: 15))
                            .bold()
                    }
                    .padding()
                    .background(Color.white.cornerRadius(11))
                    .tint(.black)
                    
                    HStack {
                        Text("Ultima potuaçáo: \(self.score) / \(myQuiz1.count)")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .onAppear() {
                                self.score = LoadScore(quiz: "myQuiz1")
                            }
                    }
                }
            }
            .navigationBarTitle("Quiz", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sair") {
                        dismiss()
                        
                    }
                    .tint(.white)
                }
            }
            .onAppear {
                UINavigationBar.appearance().tintColor = .white
                UITabBar.appearance().isTranslucent = false
                UITabBar.appearance().isHidden = true
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(score: .constant(0))
    }
}
