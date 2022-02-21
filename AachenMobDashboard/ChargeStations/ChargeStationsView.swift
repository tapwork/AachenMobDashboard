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
            .task {
                try? await api.fetch()
            }
            .refreshable {
                try? await api.fetch()
            }.redacted(reason: api.isFetching ? .placeholder : [])
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
                        ChargeStationsSocketView(socket: prop.socket)
                    }
                }
            }
        }.padding([.top, .bottom])
    }
}

struct ChargeStationsSocketView: View {
    let socket: ChargeStationsModel.Datastream.Socket
    var stateColor: Color {
        switch socket.state {
        case .available: return .green
        case .defect: return .red
        case .charging: return .orange
        case .unknown: return .gray
        }
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(socket.power) kW")
            HStack(spacing: 2) {
                Text(socket.type)
                Text(socket.name)
            }
        }
        .padding(10)
        .background(stateColor)
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
