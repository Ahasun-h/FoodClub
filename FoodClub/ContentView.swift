//
//  ContentView.swift
//  FoodClub
//
//  Created by Ahasun on 1/26/23.
//

import SwiftUI
import WebKit

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    @Binding var showLoading: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct ContentView: View {
    @State private var isLoading = false
    @State private var connection: Bool = false
    @State private var showLoading: Bool = false

    var body: some View {
        VStack {
            if connection == false {
                Nonetwork()
            } else {
                WebView(request: URLRequest(url: URL(string: "https://foodclubuk.com/login")!), showLoading: $showLoading)
                    .overlay(showLoading ? AnyView(ProgressView("Loading...")): AnyView(EmptyView()))
                .onAppear {
                    self.checkConnection()
                    self.showLoading = true
                }
                .onDisappear {
                    self.showLoading = false
                }
            }
        }
        .onAppear {
            self.checkConnection()
        }
    }
    
    func checkConnection() {
        self.isLoading = true
        
        let url = URL(string: "https://foodclubuk.com/login")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if error == nil {
                    self.connection = true
                } else {
                    self.connection = false
                }
            }
        }.resume()
    }
}
