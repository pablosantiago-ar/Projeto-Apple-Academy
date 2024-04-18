//
//  DataController.swift
//  CapitaesdeAreia
//
//  Created by aluno on 28/05/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BD")
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
            }
        }
    }
}
