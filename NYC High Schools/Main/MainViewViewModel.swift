//
//  MainViewViewModel.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import Foundation
import Combine

class MainViewViewModel: ObservableObject {
    @Published var allSchools: [HighSchool] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getSchools()
    }
    
    private func getSchools() {
        // establish eurl to fetch from
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json") else { return }
        
        // create publisher to fetch and publish data
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main) // recieve data on main thread since we need to show in UI
            .tryMap(handleOutput) // make sure fetch response is good
            .decode(type: [HighSchool].self, decoder: JSONDecoder()) // decode from json to swift object/s
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("finished fetching schools")
                case .failure(let error):
                    print("uh oh! error fetching schools: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] fetchedSchools in
                self?.allSchools = fetchedSchools // assign fetched data
            }
            .store(in: &cancellables) // store fetch receipt incase we need to cancel
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        // verfiy that response is good
        guard
            let httpResponse = output.response as? HTTPURLResponse,
            httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        // return data if response was good
        return output.data
    }
}
