//
//  CapitaesdeAreiaApp.swift
//  CapitaesdeAreia
//
//  Created by aluno on 05/04/22.
//

import SwiftUI

@main
struct CapitaesdeAreiaApp: App {
    @StateObject private var dataController  = DataController()
    var body: some Scene {
        WindowGroup {
            
            MyPageView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
