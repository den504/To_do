//
//  TodoListView.swift
//  To_do
//
//  Created by Dennis Okafor on 05/03/2026.
//

import SwiftUI

struct TodoListView: View {
    @State private var newTodoTitle = ""
    @EnvironmentObject var todoVM : TodoViewModel // Just intialised //note we using the same variable name as what was passed from app entry point
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                
                HStack {
                    TextField("New Todo Title", text: $newTodoTitle)
                    Button("Add"){
                        todoVM.addTodo(title: newTodoTitle)
                        newTodoTitle = ""
                    }
                }.padding()
                
//                Text("List goes here")
                List {
                    ForEach(todoVM.todos){ todo in
                        HStack {
                            Text(todo.title)
                            Spacer()
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture{ //tap todo onlist and it changes from on to off on the toggle
                                    todoVM.toggleCompletion(todo: todo)
                                }
                            
                        }
                        
                    }.onDelete(perform: todoVM.deleteTodo) //swipe left onlist and calls the delete function
                    
                }
            }
            
        }.navigationTitle("My Todos")
    }
}

#Preview {
    //this is an amzing gotcha
    TodoListView().environmentObject(TodoViewModel())
}
