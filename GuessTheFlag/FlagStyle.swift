//  MARK: FlagStyle.swift


import SwiftUI



struct FlagStyle: ViewModifier {
    
    func body(content: Content)
    -> some View {
        
        return content
            .clipShape(RoundedRectangle(cornerRadius : 15))
            .overlay(
                RoundedRectangle(cornerRadius : 15.0)
                    .stroke(Color.white ,
                            lineWidth : 3))
            .shadow(color : Color(white : 1.00 ,
                                  opacity : 0.65) ,
                    radius : 10)
    }
}





extension View {
    
    func styleFlag()
    -> some View {
        
        return self.modifier(FlagStyle())
    }
}
