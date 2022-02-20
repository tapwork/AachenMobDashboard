//
//  ChargeStationsView.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import SwiftUI

struct ChargeStationsView: View {
    @StateObject var api = ChargeStationsAPI()
    var body: some View {
        content
            .overlay {
                if api.isFetching { ProgressView() }
            }
            .task {
                try? await api.fetch()
            }
            .refreshable {
                try? await api.fetch()
            }
    }

    var content: some View {
        List(api.values) { value in
            Text(value.valueDescription)
        }.listStyle(.plain)
    }
}

struct ChargeStationsView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeStationsView()
    }
}
