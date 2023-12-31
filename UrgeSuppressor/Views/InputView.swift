//
//  InputView.swift
//  UrgeSuppressor
//
//  Created by Joe Monem on 06/10/2023.
//

import SwiftUI

struct InputView: View {
    @Binding var whys: [String]
    @State var why: String
    
    var body: some View {
        VStack {
            Text("He who has a why can bear any how").font(.title2).fontWeight(.bold).padding()
                
            Text("Add your why below").fontWeight(.thin)
            Form {
                HStack {
                    TextField("Why", text: $why )
                    Button(action: {
                        withAnimation{
                            whys.append(why)
                            why = ""
                        } }) {
                        Image(systemName: "plus.circle.fill")
                        }.disabled(why.isEmpty)
                }
                ForEach(whys, id: \.self) { why in
                    Text(why)
                }
                .onDelete { indices in
                    whys.remove(atOffsets: indices)
                }
  
            }
            .cornerRadius(16)
            .padding()
            Text("Swipe this page down when you're done")

            Spacer()
        }
        .padding()
    }
}

struct InputView_Preview: PreviewProvider {
    static var previews: some View {
        InputView(whys: .constant(["Just because", "Philosophy"]), why: "")
    }
}
