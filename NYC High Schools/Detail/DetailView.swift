//
//  DetailView.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import SwiftUI

struct DetailView: View {
    // we need school object passed, so that we can populate details
    var id: String
    @ObservedObject var viewModel: DetailViewViewModel
    
    init(id: String) {
        self.id = id
        self.viewModel = DetailViewViewModel(dbn: id)
    }
    
    var body: some View {
    
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Text(viewModel.schoolScores?.name ?? "")
                    .font(.title3)
                    .padding()
                
                HStack {
                    Text("Average Math Scores: ")
                    Text(viewModel.schoolScores?.mathScoreAverage ?? "score unavailable")
                }
                
                HStack {
                    Text("Average Reading Scores: ")
                    Text(viewModel.schoolScores?.readingScoreAverage ?? "score unavailable")
                }
                
                HStack {
                    Text("Average Writing Scores: ")
                    Text(viewModel.schoolScores?.writingScoreAverage ?? "score unavailable")
                }
                
                
            }
            
        }
    }
}

#Preview {
    DetailView(id: "")
}
