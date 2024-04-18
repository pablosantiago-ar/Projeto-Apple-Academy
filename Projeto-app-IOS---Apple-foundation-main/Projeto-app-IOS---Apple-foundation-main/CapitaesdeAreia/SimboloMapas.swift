//
//  SimboloMapas.swift
//  CapitaesdeAreia
//
//  Created by aluno on 14/06/22.
//

import SwiftUI

struct SimboloMapas: View {
    var body: some View {
        
        ZStack(alignment: .center){
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 14, height: 11)
                .rotationEffect(.degrees(180))
                .foregroundColor(.red)
                .offset(y: 10.8)
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .colorInvert()
                
        }
        
        
        
    }
}

struct SimboloMapas_Previews: PreviewProvider {
    static var previews: some View {
        SimboloMapas()
    }
}
