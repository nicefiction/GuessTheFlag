// AccessibleContentView.swift
// MARK: SOURCE
// https://www.hackingwithswift.com/books/ios-swiftui/fixing-guess-the-flag

// MARK: - LIBRARIES -

import SwiftUI



struct AccessibleContentView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var gameScore: Int = 0
   @State private var isShowingScoreAlert: Bool = false
   @State private var scoreTitle: String = ""
   @State private var scoreMessage: String = ""
   @State private var correctAnswer = Int.random(in: 0...2)
   @State private var countries: [String] = [
      "Estonia" , "France" , "Germany" , "Ireland" , "Italy" , "Monaco" ,
      "Nigeria" , "Poland" , "Russia" , "Spain" , "UK" , "US"
   ].shuffled()
   
   
   
   // MARK: - PROPERTIES
   
   let countryLabels: Dictionary<String, String> = [
      "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
      "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
      "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
      "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
      "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
      "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
      "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
      "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
      "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
      "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
      "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
   ]
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      ZStack {
         LinearGradient(gradient : Gradient(colors : [.blue , .white]) ,
                        startPoint : .top ,
                        endPoint : .bottom)
            .edgesIgnoringSafeArea(.all)
         VStack {
            VStack {
               Text("Guess the Flag of")
                  .fontWeight(.medium)
                  .padding(.top)
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
                  FlagImage(flagIndex : flagIndex ,
                            countries : countries)
                     .padding()
                     .accessibility(label: Text(countryLabels[countries[flagIndex], default: "Unknown flag"])) // ⭐️
               }
               .alert(isPresented: $isShowingScoreAlert) {
                  Alert(title : Text("\(scoreTitle)") ,
                        message : Text("\(scoreMessage)") ,
                        dismissButton : .default(Text("Continue")) {
                           
                           self.askQuestion()
                        })
               }
            }
            
            VStack {
               Text("Your Score")
                  .fontWeight(.medium)
               Text("\(gameScore)")
                  .font(.largeTitle)
                  .bold()
            }
            .foregroundColor(.blue)
            
            Spacer()
         }
      }
   }
   
   
   
   // MARK: - HELPERMETHODS
   
   func tapFlagWith(index: Int) {
      
      updateAlertUsing(index : index)
      updateGameScoreUsing(index : index)
      
      isShowingScoreAlert = true
   }
   
   
   func updateGameScoreUsing(index: Int) {
      
      let gameRoundScore = index == correctAnswer ? 1 : -1
      gameScore += gameRoundScore
   }
   
   
   func updateAlertUsing(index: Int) {
      
      scoreTitle = index == correctAnswer ? "🙌" : "👎"
      scoreMessage = index == correctAnswer ? "+ 1\nThat is indeed the flag of \(countries[correctAnswer]) ." : "- 1\nThat is the flag of \(countries[index]) ."
   }
   
   
   func askQuestion() {
      
      countries.shuffle()
      correctAnswer = Int.random(in : 0...2)
   }
}





// MARK: - PREVIEWS -

struct AccessibleContentView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      return AccessibleContentView()
   }
}
