//
//  HighSchool.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import Foundation

struct HighSchool: Identifiable, Codable {
    let id: String
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "dbn" // use dbn value as unique identifier for each school
        case name = "school_name"
    }
}

