// AnimatedContentViewRefactored.swift

// MARK: - LIBRARIES -

import SwiftUI



struct AnimatedContentViewRefactored: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @State private var gameScore: Int = 0
   @State private var isShowingScoreAlert: Bool = false
   @State private var scoreTitle: String = ""
   @State private var scoreMessage: String = ""
   @State private var correctAnswer = Int.random(in: 0...2)
   @State private var countries: [String] = [
      "Estonia" , "France" , "Germany" , "Ireland" , "Italy" , "Monaco" , "Nigeria" , "Poland" , "Russia" , "Spain" , "UK" , "US"
   ].shuffled()
   @State private var flagIsTapped: Bool = false
   @State private var animationAmount: CGFloat = 0.0
   
   
   
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
                  flagIsTapped.toggle()
                  
                  withAnimation(
                     Animation
                        .interpolatingSpring(stiffness : 5.00 ,
                                             damping : 1.00)) {
                     animationAmount = (flagIndex == correctAnswer) ? 360.0 : 0.0
                  }
               }) {
                  if flagIsTapped && (flagIndex == correctAnswer) {
                     FlagImage(flagIndex : flagIndex ,
                               countries : countries)
                        .rotation3DEffect(
                           .degrees(Double(animationAmount)) ,
                           axis : (x : 0.0 , y : 1.0 , z : 0.0)
                        )
                     
                  } else if flagIsTapped && (flagIndex != correctAnswer) {
                     FlagImage(flagIndex : flagIndex ,
                               countries : countries)
                        .opacity(0.25)
                     
                  } else {
                     FlagImage(flagIndex : flagIndex ,
                               countries : countries)
                  }
               }
               .padding()
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
      
      scoreTitle = index == correctAnswer ? "????" : "????"
      scoreMessage = index == correctAnswer ? "+ 1\nThat is indeed the flag of \(countries[correctAnswer]) ." : "- 1\nThat was the flag of \(countries[index]) ."
   }
   
   
   func askQuestion() {
      
      flagIsTapped = false
      animationAmount = 0.0
      countries.shuffle()
      correctAnswer = Int.random(in : 0...2)
   }
}





// MARK: - PREVIEWS -

struct AnimatedContentViewRefactored_Previews: PreviewProvider {
   
   static var previews: some View {
      
      AnimatedContentViewRefactored().previewDevice("iPhone 12 Pro")
   }
}

