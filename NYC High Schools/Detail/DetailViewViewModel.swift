//
//  DetailViewViewModel.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import Foundation
import Combine

class DetailViewViewModel: ObservableObject {
    @Published var schoolScores: SchoolSATScores?
    
    var cancellables = Set<AnyCancellable>()
    
    init(dbn: String) {
        getScores(dbn: dbn)
    }
    
    
    func getScores(dbn: String) {
        let queryUrl = createURLQuery(baseUrlString: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json", queryName: "dbn", queryValue: dbn)
        
        URLSession.shared.dataTaskPublisher(for: queryUrl)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [SchoolSATScores].self, decoder: JSONDecoder())
            .sink { (_) in
                // we would handle completion
            } receiveValue: { [weak self] scores in
                self?.schoolScores = scores.first
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let httpResponse = output.response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
    
    func createURLQuery(baseUrlString: String, queryName: String, queryValue: String) -> URL {
        var urlComponent = URLComponents(string: baseUrlString)
        urlComponent?.queryItems = [URLQueryItem(name: queryName, value: queryValue)]
        
        guard let queryUrl = urlComponent?.url else { fatalError("could not create query url") }
        
        return queryUrl
    }
}
