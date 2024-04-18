//
//  NewsView.swift
//  CapitaesdeAreia
//
//  Created by aluno on 17/05/22.
//

import SwiftUI

struct NewsView: View {
    @State var texto:String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack{
                Text("Noticias")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .offset(y: 20)
            }
            .frame(width: UIScreen.main.bounds.size.width , height: 100)
            .background(Color.init(red: 67/255, green: 151/255, blue: 117/255))
            Spacer()
                .frame(width: 20, height: 20)
            VStack{
                
                TextField("Digite um local", text: $texto)
                    .padding()
                    .border(.gray, width: 0.2)
                
                
                VStack{
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        Spacer()
                            .frame(width: 50)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .frame(width: UIScreen.main.bounds.size.width - 40)
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                        
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 75)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
    
                    
                }
                .frame(width: UIScreen.main.bounds.size.width, height: 300)
            }
            .ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                
                Text("Noticias gerais")
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .offset(x: -105)
                
                ZStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                    
                    HStack(alignment: .center){
                        Image("deslizamento")
                            .resizable()
                            .padding()
                            .cornerRadius(70)
                        
                        Spacer()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                            .frame(width: 200 ,height: 150)
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 150)
                }
                
                .frame(width: UIScreen.main.bounds.size.width - 15, height: 150)
                Spacer()
                ZStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                    
                    HStack(alignment: .center){
                        Image("deslizamento")
                            .resizable()
                            .padding()
                            .cornerRadius(70)
                        
                        Spacer()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                            .frame(width: 200 ,height: 150)
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 150)
                }
                
                .frame(width: UIScreen.main.bounds.size.width - 15, height: 150)
                Spacer()
                ZStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                    
                    HStack(alignment: .center){
                        Image("deslizamento")
                            .resizable()
                            .padding()
                            .cornerRadius(70)
                        
                        Spacer()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                            .frame(width: 200 ,height: 150)
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 150)
                }
                
                .frame(width: UIScreen.main.bounds.size.width - 15, height: 150)
                Spacer()
                ZStack(alignment: .center){
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
                    
                    HStack(alignment: .center){
                        Image("deslizamento")
                            .resizable()
                            .padding()
                            .cornerRadius(70)
                        
                        Spacer()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. ")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                            .frame(width: 200 ,height: 150)
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.size.width - 20, height: 150)
                }
                
                .frame(width: UIScreen.main.bounds.size.width - 15, height: 150)
                
            }
            .ignoresSafeArea()
            
            Spacer()
                .frame(width: 150, height: 100)
        }
        .background(Color.init(red: 235/255, green: 235/255, blue: 235/255))
        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        .ignoresSafeArea(.all)
        
        
    }
}




struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
