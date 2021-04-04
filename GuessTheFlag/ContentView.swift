//  ContentView.swift
// LIBRARIES :

import SwiftUI



struct ContentView: View {
    
    var correctAnswer = Int.random(in: 0...2)
    let countries: [String] = [
        
        "Estonia" , "France" , "Germany" , "Ireland" , "Italy" , "Monaco" , "Nigeria" , "Poland" , "Russia" , "Spain" , "UK" , "USA"
    ]
    
    
    var body: some View {
        
        ZStack {
            Color
                .blue
                .edgesIgnoringSafeArea(.all)
            VStack(spacing : 30) {
                VStack {
                    Text("Guess the Flag of")
                    Text("\(countries[correctAnswer])")
                }
                .foregroundColor(Color.white)
                
                ForEach(0..<3) { (flagIndex: Int) in
                    Button(action : {
                        print("Flag \(countries[flagIndex]) was tapped .")
                    }) {
                        Image(self.countries[flagIndex])
                            .renderingMode(.original) // The renderingMode(.original) modifier tells SwiftUI to render the original image pixels , rather than trying to recolor them as a button .
                    }
                }
                
                Spacer()
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().previewDevice("iPhone 12 Pro")
    }
}
