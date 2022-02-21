//
//  ChargeStationsView.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import SwiftUI

struct ChargeStationsView: View {
    @StateObject var api = ChargeStationsViewModel()
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
            ChargeStationsRowView(title: value.valueDescription, properties: value.datastreams)
        }.listStyle(.plain)
    }
}

struct ChargeStationsRowView: View {
    let title: String
    let properties: [ChargeStationsModel.Datastream]
    let columns = [GridItem(.adaptive(minimum: 120))]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            ScrollView(.horizontal) {
                LazyHGrid(rows: columns) {
                    ForEach(properties) {prop in
                        ChargeStationsRowKWView(power: prop.power, available: prop.isAvailble, type: prop.chargeType, socket: prop.socket)
                    }
                }
            }
        }.padding([.top, .bottom])
    }
}

struct ChargeStationsRowKWView: View {
    let power: Int
    let available: Bool
    let type: String
    let socket: String
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(power) kW")
            HStack(spacing: 2) {
                Text(type)
                Text(socket)
            }
        }
        .padding(10)
        .background(available ? .green : .red)
        .cornerRadius(10)
        .font(.caption2)
    }
}

// MARK: - Previews
struct ChargeStationsView_Previews: PreviewProvider {
    static var previews: some View {
        ChargeStationsView()
    }
}
