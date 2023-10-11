//
//  ContentView.swift
//  UrgeSuppressor
//
//  Created by Joe Monem on 06/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Binding var whys: [String]
    @State private var isPresentingInput = false
    @State var reason: String = ""
    
    let saveAction: ()->Void
    
    
    var body: some View {
        VStack {
            Text("He who has a why to live for can bear almost any how").font(.title).fontWeight(.bold).padding()
            Button("Get a why") {
                reason = whys.randomElement()!
            }
            .disabled(whys.isEmpty).padding()
            
            Text(reason).font(.title).fontWeight(.light).padding()
            
            Spacer()
            Button("Add a why") {
                isPresentingInput = true
            }
            .sheet(isPresented: $isPresentingInput) {
                InputView(whys: $whys, why: $reason)
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(whys: .constant(["hey"]), saveAction: {})
    }
}
