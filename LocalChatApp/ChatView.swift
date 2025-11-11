//
//  ContentView.swift
//  LocalChatApp
//
//  Created by Greg on 11/11/2025.
//

import SwiftUI
import FoundationModels

struct ChatView: View {
    @State private var input = ""
    @State private var session = LanguageModelSession()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(session.transcript) { entry in
                        switch entry {
                        case .prompt(let response):
                            Text(segmentsToString(segments: response.segments))
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(lineWidth: 1)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal)
                        case .response(let response):
                            Text(segmentsToString(segments: response.segments))
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(lineWidth: 1)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            .navigationTitle("Local Chat")
            .toolbar {
                Button("Reset", systemImage: "arrow.counterclockwise") {
                    session = LanguageModelSession()
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("How can I help you?", text: $input)
                        .textFieldStyle(.roundedBorder)
                    Button("Send", systemImage: "paperplane") {
                        Task {
                            do {
                                try await session.respond(to: input)
                                input.removeAll()
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .labelStyle(.iconOnly)
                    .padding()
                    .glassEffect()
                }
                .padding()
            }
        }
    }
    func segmentsToString(segments: [Transcript.Segment]) -> String {
        let strings = segments.compactMap { segment -> String? in
            if case let .text(textSegment) = segment {
                return textSegment.content
            }
            return nil
        }
        return strings.reduce("", +)
    }
}

#Preview {
    ChatView()
}
