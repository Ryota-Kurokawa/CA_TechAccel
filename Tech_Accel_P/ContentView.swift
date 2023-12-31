//
//  ContentView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var newitem = ""
    @State var TaskList: [Task] = []
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
                        Text(task.title)
                    }
                    .onDelete { indices in
                        TaskList.remove(atOffsets: indices)
                        saveTasks()
                    }
                }
                HStack {
                    TextField("quick make", text: $newitem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 150, height: 50, alignment: .center)
                        .onSubmit() {
                            if !newitem.isEmpty{
                                let task = Task(title: newitem, description: "", isDone: false)
                                TaskList.append(task)
                                saveTasks()
                                newitem = ""
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
                        makeTask(TaskList: $TaskList)
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
    mutating func removeTask(offsets: IndexSet) {
        TaskList.remove(atOffsets: offsets)
        saveTasks()
    }
}

#Preview {
    ContentView()
}
