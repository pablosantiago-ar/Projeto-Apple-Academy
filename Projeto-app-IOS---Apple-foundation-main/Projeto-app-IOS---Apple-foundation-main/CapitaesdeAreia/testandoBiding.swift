//
//  SwiftUIView.swift
//  CapitaesdeAreia
//
//  Created by aluno on 07/06/22.
//

import SwiftUI

struct MyView1: View {
    
    @Binding var c1: Int
    
    @State var a = 10
    
    var body: some View {
        Text("MyView1")
    }
}

struct MyView2: View {
    
    @Binding var c2: Int
    
    @State var b = 10
    
    var body: some View {
        Text("MyView2")
    }
}

struct SwiftUIView: View {
    
    @State var c = 30
    
    var body: some View {
        TabView {
            MyView1(c1: $c)
                .tabItem {
                    Text("1")
                }
            MyView2(c2: $c)
                .tabItem {
                    Text("2")
                }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
