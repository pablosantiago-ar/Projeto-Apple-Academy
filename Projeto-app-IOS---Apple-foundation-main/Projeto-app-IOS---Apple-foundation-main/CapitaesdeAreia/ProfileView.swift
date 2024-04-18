//
//  TelaLogin.swift
//  LuvaDePedreiroCard
//
//  Created by aluno on 29/04/22.
//

import SwiftUI

struct TelaLogin: View {
    var icons = ["house.fill","map.fill", "newspaper.fill", "person.fill" ]
    @State var imageSelected =  UIImage(named: "profile")!
    let greenColor: Color = Color.init(red: 67/255, green: 151/255, blue: 117/255)
    
    var profileHeader: some View {
        VStack(spacing: 10) {
            //            Image(uiImage: imageSelected)
            //                .resizable()
            //                .scaledToFit()
            //                .frame(width: 150, height: 150)
            //                .clipShape(Circle())
            Image(uiImage: imageSelected)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            //.overlay(Circle().stroke(Color.white, lineWidth: 5))
            Text("@Profile")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.white)
        }
    }
    
    var titleView: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .black.opacity(0.9),
                    greenColor.opacity(0.1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
                .frame(height: 100)
            
            Text("PERFIL")
                .font(.system(size: 24, weight: .heavy, design: .default))
                .bold()
                .foregroundColor(.white)
                .padding(.top, 50)
        }
    }
    
    var proportionalYOffset: Double {
        UIScreen.main.bounds.height * 0.05
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack {
                    ZStack(alignment: .top) {
                        
                        greenColor
                        
                        VStack {
                            titleView
                            profileHeader
                            VStack {
                                HStack(alignment: .center , spacing: 35) {
                                    Text("Since: \n 2022")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("Denúncias \n       73")
                                        .font(.system(size: 20, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                    
                                    
                                }
                            }
                            .fixedSize()
                            .frame(width: 200, height: 100)
                            .padding(.horizontal, 50)
                            .background(Color.init(red: 44/255, green: 99/255, blue: 75/255))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .offset(y: proportionalYOffset)
                            
                        }
                        
                    }
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                    
                    ZStack (alignment: .leading){
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                            .offset(y: 150)
                        VStack(alignment: .leading, spacing: 22){
                            
                            Button(action: {}) {
                                Text(" INFORMAÇÕES PESSOAIS")
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding()
                            
                            }
                            Divider()
                            Button(action: {}) {
                                Text(" AJUDA")
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding()
                            }
                            Divider()
                            //Button(action: {(destination: SettingsView())}) {
                            //Text(" CONFIGURAÇÕES")
                            //}
                            
                            NavigationLink(destination: SettingsView(imageSelected: $imageSelected), label: {
                                
                                Text(" CONFIGURAÇÕES")
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding()
                                    .foregroundColor(.black)
                            })
                            Divider()
                            
                            Button(action: {}) {
                                Text(" CRÉDITOS")
                                    .font(.system(size: 22, weight: .regular, design: .default))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .padding()
                            }
                            Divider()
                            
                        }
                        .font(.system(size: 25, weight: .light, design: .serif))
                        .tint(.black)
                    }
                    Spacer()
                        .frame(width: UIScreen.main.bounds.size.width, height: 60)
                    
                }
                .ignoresSafeArea()
                Spacer()
                .frame(width: UIScreen.main.bounds.size.width, height: 20)
                .navigationBarHidden(true)
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
        .background(Color.white)
    }
}

struct ImageIcon: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

struct TelaLogin_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TelaLogin(imageSelected: UIImage())
            
        }
    }
}
