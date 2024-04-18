//
//  QuizModel.swift
//  quiz
//
//  Created by aluno on 14/06/22.
//

import Foundation

struct QuizModel {
    var img: String?
    var text: String?
    var answer: [String]
    
    var correct: Int?
}

//questao1
var myQuiz1: [QuizModel] = [
    //q1
    QuizModel(img: "",
              text: "Para morar em um local seguro, é necessário haver um planejamento adequado para a ocupação do terreno?",
              answer: ["Sim", "Nao"],
              correct: 0),
    //q2
    QuizModel(img: "",
              text: "Uma solução que pode amenizar o risco de deslizamento da terra é plantar grama e/ou capim nas encostas no terreno.",
              answer: ["Sim, pois as raízes penetram o solo, evitando, assim, o desmoronamento.", "Não, a afirmação está incorreta."],
              correct: 0),
    //q3
    QuizModel(img: "",
              text: "A afirmação “Para evitar riscos de desmoronamento, é necessário evitar o desmatamento e ocupação em uma encosta”.",
              answer: ["É verdadeira", "É falsa"],
              correct: 0),
    //q4
    QuizModel(img: "",
              text: "As causas do deslizamento, é apenas por fatores humanos?",
              answer: ["Sim", "Não, além dos fatores humanos, têm os fatores naturais."],
              correct: 1),
    //q5
    QuizModel(img: "",
              text: "João afirma para Rodrigo: 'O ser humano não é responsável pelos desmoronamentos e deslizamentos da terra, ninguém é culpado, pois esses problemas são apenas naturais, irão sempre acontecer. A afirmação é:",
              answer: ["Verdadeira", "Falsa"],
              correct: 1),
    //q6
    QuizModel(img: "",
              text: "O que eu devo fazer ao ver uma encosta com casa com risco de desmoronamento?",
              answer: ["Avisar ao Corpo de Bombeiros e a Defesa Civil", "Sair de perto"],
              correct: 0),
    //q7
    QuizModel(img: "",
              text: "Ao fazer qualquer modificação no terreno, primeiramente é necessário solicitar uma licença da prefeitura?",
              answer: ["O terreno é exclusividade do seu proprietário, cabendo a ele fazer o que bem entender e achar melhor", "Ao ter anuência da prefeitura, o proprietário ser ver livre de penalidades além da segurança de sua vizinhança."],
              correct: 1),
]

func SaveScore(quiz: String, score: Int){
    UserDefaults.standard.set(score, forKey: quiz)
}

func LoadScore(quiz: String) -> Int {
    return UserDefaults.standard.integer(forKey: quiz)
}


