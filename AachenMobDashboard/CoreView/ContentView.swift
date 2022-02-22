//
//  ContentView.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import SwiftUI
import ChargeStations

struct ContentView: View {
    var body: some View {
        NavigationView {
            ChargeStationsView()
            .navigationTitle("Aachen Mob Dashboard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
