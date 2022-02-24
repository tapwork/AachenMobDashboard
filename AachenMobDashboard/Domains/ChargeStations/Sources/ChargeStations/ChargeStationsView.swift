//
//  ChargeStationsView.swift
//  AachenMobDashboard
//
//  Created by Christian Menschel on 20.02.22.
//

import SwiftUI

public struct ChargeStationsView: View {
    @StateObject var viewModel = ChargeStationsViewModel()

    public init() {}

    public var body: some View {
        contentView
            .task {
                await viewModel.fetch()
            }
            .refreshable {
                await viewModel.fetch()
            }.redacted(reason: viewModel.isFetching ? .placeholder : [])
    }

    public var contentView: some View {
        List(viewModel.content) { value in
            ChargeStationsRowView(value: value)
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchTerm)
        .navigationTitle("Ladesäulen")
    }
}

struct ChargeStationsRowView: View {
    @State private var showActionSheet = false
    let value: ChargeStationsModel.Value
    var title: String {
        value.valueDescription
    }
    var properties: [ChargeStationsModel.Datastream] {
        value.datastreams
    }
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
        }
        .onTapGesture {
            showActionSheet.toggle()
        }
        .padding([.top, .bottom])
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Navigation"),
                message: Text("Zur Ladesäule navigieren?"),
                buttons: [
                    .default(Text("Google Maps"), action: { open(value.googleMapsURL) }),
                    .default(Text("Apple Maps"), action: { open(value.appleMapsURL) }),
                    .cancel(Text("Abbrechen"))
                ]
            )
        }
    }

    func open(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
