// MARK: ContentView.swift

 

 // ///////////////
// MARK: LIBRARIES

import SwiftUI


 
 

 // /////////////////////////////
//  MARK: struct ContentView { }

struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @State private var score: Int = 0
    @State private var isShowingScoreAlert: Bool = false
    @State private var scoreTitle: String = ""
    @State private var scoreMessage: String = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries: [String] = [
        "Estonia" , "France" , "Germany" , "Ireland" , "Italy" , "Monaco" , "Nigeria" , "Poland" , "Russia" , "Spain" , "UK" , "US"
    ].shuffled()
    
    
    
    // /////////////////
   //  MARK: PROPERTIES
    
    
    
    // //////////////////////////
   //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient : Gradient(colors : [.blue , .white]) ,
                           startPoint : .top ,
                           endPoint : .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing : 30) {
                VStack {
                    Text("Guess the Flag of")
                        .fontWeight(.medium)
                    Text("\(countries[correctAnswer])")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundColor(Color.white)
                
                ForEach(0..<3) { (flagIndex: Int) in
                    Button(action : {
                        print("Flag \(countries[flagIndex]) was tapped .")
                        self.tapFlagWith(index : flagIndex)
                    }) {
                        Image(self.countries[flagIndex])
                            .renderingMode(.original) // The renderingMode(.original) modifier tells SwiftUI to render the original image pixels , rather than trying to recolor them as a button .
                            .clipShape(RoundedRectangle(cornerRadius : 15))
                            .overlay(
                                RoundedRectangle(cornerRadius : 15.0)
                                    .stroke(Color.white ,
                                            lineWidth : 3))
                            .shadow(color: Color(white : 1.00 ,
                                                 opacity : 0.65) ,
                                    radius : 10)
                    }
                    .alert(isPresented: $isShowingScoreAlert) {
                        Alert(title : Text("\(scoreTitle)") ,
                              message : Text("\(scoreMessage) Your game score is now \(score) .") ,
                              dismissButton : .default(Text("Continue")) {
                                
                                self.askQuestion()
                              })
                    }
                }
                Spacer()
            }
        }
    }
    

    
    // //////////////
   //  MARK: METHODS
    
    
    
    // ////////////////////
   //  MARK: HELPERMETHODS
    
    func tapFlagWith(index: Int) {
        
        updateAlertUsing(index : index)
        updateGameScoreUsing(index : index)
        
        isShowingScoreAlert = true
    }
    
    
    func updateGameScoreUsing(index: Int) {
        
        let gameRoundScore = index == correctAnswer ? 1 : -1
        score += gameRoundScore
    }
    
    
    func updateAlertUsing(index: Int) {
        
        scoreTitle = index == correctAnswer ? "🙌" : "👎"
        scoreMessage = index == correctAnswer ? "+ 1\n" : "- 1\n"
    }
    
    
    func askQuestion() {
        
        countries.shuffle()
        correctAnswer = Int.random(in : 0...2)
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().previewDevice("iPhone 12 Pro")
    }
}
