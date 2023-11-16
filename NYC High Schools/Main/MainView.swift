//
//  ContentView.swift
//  NYC High Schools
//
//  Created by Eric Barnes - iOS on 11/16/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        ZStack {
            // background
            Color.white
                .ignoresSafeArea()
            
            
            VStack {
                // Title
                Text("New York High Schools")
                
                // list of schools
                NavigationStack {
                    List {
                        ForEach(viewModel.allSchools) { school in
                            NavigationLink(school.name, destination: DetailView(id: school.id))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}

// Pass dbn/id and use to fetchn details for specific school 
