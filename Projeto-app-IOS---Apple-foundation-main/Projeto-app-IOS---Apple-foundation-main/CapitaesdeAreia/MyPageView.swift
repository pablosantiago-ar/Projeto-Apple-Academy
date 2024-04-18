//
//  MyPageView.swift
//  CapitaesdeAreia
//
//  Created by aluno on 12/04/22.
//

import SwiftUI
import CoreLocation

struct MyPageView: View{
    
    @State var annotations = [
        Place(name: "Burguer Place", coordinate: CLLocationCoordinate2D(latitude: -3.71845, longitude: -38.5436))
        
    ]
    
    @State var userLocation: (String, String) = ("","")
    
    @State var selection = 1
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = .white
//        UITabBar.appearance().backgroundColor = UIColor.cyan
//        UITabBar.appearance().
        
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ContentView(selection: $selection, annotations: $annotations, score: 0)
                .tabItem{
                    Image(systemName: "house").renderingMode(.template)
                    Text("Início")
                }
                .tag(1)
            
            MapView(annotations: $annotations)
                .tabItem {
                    Image(systemName: "map").renderingMode(.template)
                    Text("Mapa")
                }
                .tag(2)
            
                NewsView()
                .tabItem {
                    Image(systemName: "newspaper").renderingMode(.template)
                    Text("Notícias")
                }
                .tag(3)
            
                TelaLogin()
                .tabItem {
                    Image(systemName: "person").renderingMode(.template)
                    Text("Perfil")
                }
                .tag(4)
                
        }
        .accentColor(Color.init(red: 67/255, green: 151/255, blue: 117/255))
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
//        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
