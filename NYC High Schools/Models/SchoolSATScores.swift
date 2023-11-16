//
//  SchoolSATScores.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import Foundation

struct SchoolSATScores: Identifiable, Codable {
    let id: String
    let name: String
    let readingScoreAverage: String
    let writingScoreAverage: String
    let mathScoreAverage: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case name = "school_name"
        case readingScoreAverage = "sat_critical_reading_avg_score"
        case writingScoreAverage = "sat_writing_avg_score"
        case mathScoreAverage = "sat_math_avg_score"
    }
}
