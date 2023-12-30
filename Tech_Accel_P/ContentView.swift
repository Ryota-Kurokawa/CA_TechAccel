//
//  ContentView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var newitem = ""
    @State var TaskList = UserDefaults.standard.array(forKey: "TaskList") as? [String] ?? []
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20,alignment: .center)
            HStack{
                Spacer()
                Text("Tech Accel")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Spacer()
            }
            List {
                ForEach(TaskList, id: \.self) { task in
                    Text("\(task)")
                }
                .onDelete { indices in
                    // 指定された行を削除する
                    TaskList.remove(atOffsets: indices)
                    // 削除後のTaskListをUserDefaultsに再保存
                    UserDefaults.standard.set(TaskList, forKey: "TaskList")
                }
            }
            HStack{
                TextField("new your task", text: $newitem)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                Button(action: {
                    self.TaskList.append(self.newitem)
                    UserDefaults.standard.set(self.TaskList, forKey: "TaskList")
                    self.newitem = ""
                }){
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 50, height: 30)
                            .foregroundColor(.green)
                        Text("add")
                            .foregroundColor(.white)
                    }
                }
            }
            Spacer()
        }.onAppear() {
            // 既に`TaskList`が`UserDefaults`に保存されているか確認する
            if let savedList = UserDefaults.standard.array(forKey: "TaskList") as? [String] {
                self.TaskList = savedList
            } else {
                // `TaskList`が存在しない場合は初期化
                UserDefaults.standard.set(self.TaskList, forKey: "TaskList")
            }
        }
    }
    mutating func RemoveTask(offsets: IndexSet){
        TaskList.remove(atOffsets: offsets)
        UserDefaults.standard.set(TaskList, forKey: "TaskList")
    }
}

#Preview {
    ContentView()
}
