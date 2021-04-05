//  FlagImage.swift



 // ////////////////
//  MARK: LIBRARIES

import SwiftUI





 // /////////////////////////////////
//  MARK: struct FlagImage: View { }

struct FlagImage: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    let flagIndex: Int
    let countries: [String]
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        Image(self.countries[flagIndex])
            .renderingMode(.original) // The renderingMode(.original) modifier tells SwiftUI to render the original image pixels , rather than trying to recolor them as a button .
            .styleFlag()
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct FlagImage_Previews: PreviewProvider {
    
    static var previews: some View {
        FlagImage(flagIndex : 0 ,
                  countries : ["Italy"])
            .previewLayout(.sizeThatFits)
    }
}
