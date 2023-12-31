//
//  ContentView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var title = ""
    @State var TaskList: [Task] = []
    @State var selected: Task = Task(title: "", description: "", isDone: false)
    @State private var isShowingView: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 20,alignment: .center)
                HStack {
                    Spacer()
                    Text("Tech Accel")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Spacer()
                }
                List {
                    ForEach(TaskList, id: \.self) { task in
                        NavigationLink(destination: DetailView(task: self.$TaskList[TaskList.firstIndex(of: task)!])) {
                            Text(task.title)
                        }
                    }
                    .onDelete { indices in
                        TaskList.remove(atOffsets: indices)
                        saveTasks()
                    }
                }
                HStack {
                    TextField("quick make", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150, height: 50, alignment: .center)
                        .onSubmit() {
                            if !title.isEmpty{
                                let task = Task(title: title, description: "", isDone: false)
                                TaskList.append(task)
                                saveTasks()
                                title = ""
                            }
                        }
                    Button {
                        isShowingView.toggle()
                    } label: {
                        Text("詳細登録")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isShowingView) {
                        MakeTask(title: $title, TaskList: $TaskList)
                    }
                }
                Spacer()
            }.onAppear() {
                // Viewが表示される際にUserDefaultsからデータを取得
                if let data = UserDefaults.standard.data(forKey: Task.storeKey) {
                    do {
                        TaskList = try JSONDecoder().decode([Task].self, from: data)
                    } catch {
                        print("Error decoding tasks: \(error)")
                    }
                }
            }
        }
    }
    func saveTasks(){
        do {
            let data = try JSONEncoder().encode(TaskList)
            UserDefaults.standard.set(data, forKey: Task.storeKey)
        } catch{
            print(error)
        }
    }
    init(){
        if let data = UserDefaults.standard.data(forKey: Task.storeKey){
            do {
                TaskList = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
