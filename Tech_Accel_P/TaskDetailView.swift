//
//  DetailView.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/31.
//

import SwiftUI

struct DetailView: View {
    @Binding var task: Task
    
    var body: some View {
        VStack (spacing: 10){
            Spacer().frame(height: 100)
            Text(task.title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            Text(task.description)
                .frame(height: 100)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Spacer()
        }
    }
}
