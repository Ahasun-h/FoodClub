//
//  ContentView.swift
//  FoodClub
//
//  Created by Ahasun on 1/26/23.
//

import SwiftUI
import Network
import WebKit

// Check Device network connection
class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var isActive = false
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}


extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}


struct ContentView: View {
    
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showLoading: Bool = false

    var body: some View {
        ZStack {
            if(networkMonitor.isActive == true){
                NavigationView{
                    WebView(url: URL(string: "https://foodclubuk.com")!, showLoading: $showLoading)
                        .overlay(showLoading ? ProgressView("Loading...").toAnyView(): EmptyView().toAnyView())
                        .navigationBarHidden(true)
                }
            }
            else{
                Nonetwork()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .edgesIgnoringSafeArea([.bottom])
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
