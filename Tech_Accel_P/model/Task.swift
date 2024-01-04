//
//  Task.swift
//  Tech_Accel_P
//
//  Created by 黒川良太 on 2023/12/26.
//
//
import Foundation

struct Task: Codable, Hashable {

    static let storeKey = "TaskListKey"

    let title: String
    let description: String
    let isDone: Bool

    init(title: String, description: String, isDone: Bool) {
        self.title = title
        self.description = description
        self.isDone = isDone
    }
}
