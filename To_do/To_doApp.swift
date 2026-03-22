//
//  To_doApp.swift
//  To_do
//
//  Created by Dennis Okafor on 05/03/2026.
//

import SwiftUI

@main
struct To_doApp: App {
    
    @StateObject var todoVM = TodoViewModel() //creating this object of TodoViewModel - @stateobject to protect state of instance
    
    var body: some Scene {
        WindowGroup {
            TodoListView().environmentObject(todoVM) //passing the state object as an evironment object
        }
    }
}
