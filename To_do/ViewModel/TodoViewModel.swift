//
//  TodoViewModel.swift
//  To_do
//
//  Created by Dennis Okafor on 05/03/2026.
//

//
//  TodoViewModel.swift
//  LearningDay
//
//  Created by Dennis Okafor on 05/03/2026.
//

import Foundation
import SwiftUI
import Combine

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    private let todosKey = "myTodosList"//publishing array of objects , much easier than int as int has to be optional
    init() {
        loadTodos()
    }
 
    
    // just note this property is added not because Todo itself but it's an array of Todo
    
    func addTodo(title: String){
        let newTodo = Todo(title:title, isCompleted:false)
        todos.append(newTodo)
        saveTodos()
    }
    
    func toggleCompletion (todo: Todo){
        //attempting to get todo via its unique id
        if let index = todos.firstIndex(where: {$0.id == todo.id}){
            todos[index].isCompleted.toggle()
            saveTodos()
        }
    }
    
    func deleteTodo (offsets: IndexSet){ //might want to save this
        todos.remove(atOffsets: offsets) // need Swift UI imported
        saveTodos()
        //guessing this works with gestures or we somehow need to  the position of what needs deleting
    }
    
    //PUT //POST - Happens before GET
    private func saveTodos(){
        
        // make the struct json
        if let encoded = try? JSONEncoder().encode(todos){
            print(encoded)
            
            //save the json as a string
            if let jsonString = String(data: encoded, encoding: .utf8){
                print(jsonString)  //after encoding still needs to get stored as a string
            }else{
                print("Error, unable to convert encoded value to String")
            }
            
            //make it an environmental variable
            UserDefaults.standard.set(encoded, forKey: todosKey)
        }
    }
    
    //GET - Happens after PUT and POST
    func loadTodos() {
        // retrive value of environment variable as a json string
        if let savedData = UserDefaults.standard.data(forKey: todosKey){
            //takes json string and transforms to a struct
            //anything type.self means "this is how the type is stored in memory - e.g
            // String.self means "this is how strings are stored in memory
            // [Todo].self just says "this is how Todo is stored in memory
            
            if let decodedTodos = try? JSONDecoder().decode([Todo].self, from: savedData){
                self.todos = decodedTodos
                return
                
                //anytime you create an object of a class the self variables belong to the overall class
                //itself - init simply takes values you enter when calling the class as makes it equal to calues
                //for the overall class itself
            }
        } else{
            self.todos = []
        }
        
        
    }
}



