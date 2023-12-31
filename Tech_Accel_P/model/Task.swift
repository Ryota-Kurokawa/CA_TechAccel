//
//  Task.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//
//
import Foundation

struct Task: Codable, Identifiable, Hashable {

    static let storeKey = "TaskListKey"

    let id: String
    let title: String
    let description: String
    let isDone: Bool

    init(id: String = UUID().uuidString, title: String, description: String, isDone: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.isDone = isDone
    }
}
