//
//  ContentView.swift
//  LocalChatApp
//
//  Created by Greg on 11/11/2025.
//

import SwiftUI

struct ChatView: View {
    @State private var input = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Text("Hello World")
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                    Text("Hello system")
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(lineWidth: 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
            .navigationTitle("Local Chat")
            .toolbar {
                Button("Reset", systemImage: "arrow.counterclockwise") {
                    
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("How can I help you?", text: $input)
                        .textFieldStyle(.roundedBorder)
                    Button("Send", systemImage: "paperplane") {
                        
                    }
                    .labelStyle(.iconOnly)
                    .padding()
                    .glassEffect()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChatView()
}
