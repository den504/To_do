//
//  To_do.swift
//  To_do
//
//  Created by Dennis Okafor on 05/03/2026.
//

import Foundation

struct Todo: Codable, Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}
