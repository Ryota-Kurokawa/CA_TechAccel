//
//  makeTask.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct MakeTask: View {
    @Binding public var title: String
    @State private var description: String = ""
    @Binding public var taskList: [Task]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Text("詳細画面設定")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(50)
                Text("Tech Accel")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Spacer()
            }
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Description", text: $description)
                .frame(height: 100)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Spacer().frame(height: 100)
            Button {
                let task = Task(title: title, description: description, isDone: false)
                taskList.append(task)
                saveTasks()
                dismiss()
                title = ""
            } label: {
                Text("完了")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        
    }
    func saveTasks(){
        do {
            let data = try JSONEncoder().encode(taskList)
            UserDefaults.standard.set(data, forKey: Task.storeKey)
        } catch{
            print(error)
        }
    }
}
