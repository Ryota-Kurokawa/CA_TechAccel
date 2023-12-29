//
//  ContentView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//

import SwiftUI

struct ContentView: View {
    @State var newitem = ""
    @State var TaskList = UserDefaults.standard.array(forKey: "TaskList")
    
    
    var body: some View {
        VStack {
            HStack{
                Text("Tech Accel")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Spacer()
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
            List {
                ForEach(TaskList, id: \.self) { task in
                    Text("\(task)")
                }
                .onDelete { indices in
                    UserDefaults.removeObject(forKey: "TaskList")
                    TaskList.remove(atOffsets: indices)
                    UserDefaults.standard.set(TaskList, forKey: "TaskList")
                }
            }
            
            
            Spacer()
        }.onAppear(){
            guard let defaultItem = TaskList
            else{return}
            self.TaskList = defaultItem
            if self.TaskList != UserDefaults.standard.array(forKey: "TaskList") as? [String] {
                UserDefaults.standard.removeObject(forKey: "TaskList")
                UserDefaults.standard.set(self.TaskList, forKey: "TaskList")
            }
        }
    }
    //    func RemoveTask(offsets: IndexSet){
    //        TaskList.remove(atOffsets: offsets)
    //    }
    
    func RemoveTask(offsets: IndexSet){
        TaskList.remove(atOffsets: offsets)
        UserDefaults.standard.removeObject(forKey: "TaskList")
        UserDefaults.standard.set(self.TaskList, forKey: "TaskList")
    }
}

#Preview {
    ContentView()
}
