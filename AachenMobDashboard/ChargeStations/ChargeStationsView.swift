//
//  ChargeStationsView.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import SwiftUI

struct ChargeStationsView: View {
    @StateObject var viewModel = ChargeStationsViewModel()

    var body: some View {
        contentView
            .task {
                try? await viewModel.fetch()
            }
            .refreshable {
                try? await viewModel.fetch()
            }.redacted(reason: viewModel.isFetching ? .placeholder : [])
    }

    var contentView: some View {
        List(viewModel.content) { value in
            ChargeStationsRowView(title: value.valueDescription, properties: value.datastreams)
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchTerm)
        .navigationTitle("Ladesäulen")
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
        NavigationView {
            ChargeStationsView()
        }
    }
}
