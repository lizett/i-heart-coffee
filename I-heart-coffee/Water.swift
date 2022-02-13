//
//  Water.swift
//  I-heart-coffee
//
//  Created by Susan Tovar on 1/29/22.
//

import SwiftUI


struct Water: View {
    //    @EnvironmentObject var favorites: Favorites
    @State var animationInProgress = true
    @State var brewModel: BrewModel
    @State var waterAmount: Int = 1
    
    @State var grindsSelection = "tbsp"
    var grindOptions = ["tbsp", "grams"]
    
    //    var resultGrindCalc: Double {
    //
    //        var value = Double(0)
    //    }
    //    switch grindsSelection {
    //    case "tbsp" || brewModel.frenchPress:
    //        value = Double(waterAmount) * 2.5
    //
    //    }
    //
    
    func computeGrinds () -> Double {
        switch brewModel {
        case .frenchPress, .chemex:
            return (2.5 * Double(waterAmount))
        case .drip :
            return Double(2 * Double(waterAmount))
        case .mokaPot:
            return Double(1 * Double(waterAmount))
        case .aeroPress:
            return Double(1.6 * Double(waterAmount))
            //        default:
            //            return(1 * Double(waterAmount))
        }
    }
    var body: some View {
        VStack (spacing: 5) {
            Spacer()
            HStack {
                //                Text("").padding(20)
                Text("How many cups do you want to brew?")
                
                Picker("", selection: $waterAmount) {
                    ForEach(1...15, id: \.self){
                        Text("\($0)")
                    }
                }
                //                Spacer()
            }.padding()
                .overlay (
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("Custom Color"), lineWidth: 8)
                )
            
            //            gif/image conditionals
            if (brewModel == .frenchPress) {
                LottieView(name: "frenchpress", loopMode: .loop)
            } else if brewModel == .chemex {
                LottieView(name: "pourover", loopMode: .loop)
            } else if brewModel == .aeroPress {
                LottieView(name: "aeropress", loopMode: .loop)
            } else if brewModel == .mokaPot {
                LottieView(name: "mokapot", loopMode: .loop)
            } else if brewModel == .drip {
                Image("Drip")
                    .resizable()
                    .scaledToFit()
                    .padding(5) // Width of the border
                    .background(Color.primary) // Color of the border
                    .cornerRadius(10) // Outer corner radius
            }
            
            let formatted = String(format: "%.2f", computeGrinds())
            
            HStack {
                Text("**\(formatted)**")
                Picker("Select Grinds Units: ", selection: $grindsSelection, content: {
                    ForEach(grindOptions, id: \.self) {
                        Text($0)
                    }
                }).onChange(of: grindsSelection) { _ in    computeGrinds()  }
                Text("of coffee grinds needed")
                
            }
            .padding()
            .overlay (
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("Custom Color"), lineWidth: 8)
            )
            
        }
        
        Spacer()
        //            Button(favorites.contains(brew) ? "Remove from Favorites" : "Add to Favorites") {
        //                        if favorites.contains(brew) {
        //                            favorites.remove(brew)
        //                        } else {
        //                            favorites.add(brew)
        //                        }
        //                    }
        //                        .buttonStyle(.borderedProminent)
        //                        .padding()
    }
}


struct Water_Previews: PreviewProvider {
    static var previews: some View {
        //        if need to delete favorites, can delete this navigation view too if not using nav view in this water view
        NavigationView {
            Water(brewModel: .drip)
        }
        //        .environmentObject(Favorites())
    }
}
