//
//  ContentView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct TaskListView: View {
    @State var title = ""
    enum Const {
        static let hoge = "TechAccel"
    }
    @State var taskList: [Task] = []
    @State var selected: Task = Task(title: "", description: "", isDone: false)
    @State private var isShowingView: Bool = false
    @State var onPressedTop: Bool = false
    @State var onPressedShare: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer().frame(height: 20, alignment: .center)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Menu(content: {
                                NavigationLink(destination: TaskListView()){
                                    Text("Top Page")
                                }
                                NavigationLink(destination: ShareView()){
                                    Text("Share Page")
                                }
                            }, label: {
                                Image(systemName: "list.bullet")
                            })
                        }
                    }
                HStack(spacing: 20) {
                    Spacer()
                    Text(Const.hoge)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Spacer()
                }
                List {
                    ForEach(taskList, id: \.self) { task in
                        NavigationLink(destination: DetailView(task: self.$taskList[taskList.firstIndex(of: task)!])) {
                            Text(task.title)
                        }
                    }
                    .onDelete { indices in
                        taskList.remove(atOffsets: indices)
                        saveTasks()
                    }
                }
                HStack(spacing: 20) {
                    TextField("quick make", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150, height: 50, alignment: .center)
                        .onSubmit() {
                            if !title.isEmpty{
                                let task = Task(title: title, description: "", isDone: false)
                                taskList.append(task)
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
                        MakeTask(title: $title, taskList: $taskList)
                    }
                }
                Spacer()
            }.onAppear() {
                // Viewが表示される際にUserDefaultsからデータを取得
                if let data = UserDefaults.standard.data(forKey: Task.storeKey) {
                    do {
                        taskList = try JSONDecoder().decode([Task].self, from: data)
                    } catch {
                        print("Error decoding tasks: \(error)")
                    }
                }
            }
        }
    }
    func saveTasks(){
        do {
            let data = try JSONEncoder().encode(taskList)
            UserDefaults.standard.set(data, forKey: Task.storeKey)
        } catch{
            print(error)
        }
    }
    init(){
        if let data = UserDefaults.standard.data(forKey: Task.storeKey){
            do {
                taskList = try JSONDecoder().decode([Task].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    TaskListView()
}
