//
//  ContentView.swift
//  SetGame
//
//  Created by 김현식 on 2021/01/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SetGameViewModel
    var body: some View {
        VStack{
            Grid(viewModel.cards){
                card in CardView(card: card).onTapGesture{
                    viewModel.choose(card: card)
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SetGameViewModel())
    }
}

struct CardView: View{
    var card : SetGameModel.Card
    var shapeColor : Color{
        card.cardContent.shapeColor.color()
    }
    var shapeOpacity: Double {
        card.cardContent.fill.rawValue
    }
    

    var body : some View{
        GeometryReader{ geometry in
            //@Viewbuilder, if it is function
            ZStack{
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                VStack{
                    ForEach(0..<card.cardContent.count.rawValue){_ in
                        switch card.cardContent.shape{
                        case .diamond:
                            Capsule()
                                .strokeBorder(shapeColor,lineWidth: 2)
                                .background(Capsule().foregroundColor(shapeColor.opacity(shapeOpacity)))
                                .padding(3)
                                .aspectRatio(2, contentMode: .fit)
                        case .rectangle:
                            Rectangle()
                                .strokeBorder(shapeColor,lineWidth: 2)
                                .background(Rectangle().foregroundColor(shapeColor.opacity(shapeOpacity)))
                                .padding(3)
                                .aspectRatio(2, contentMode: .fit)
                        case .ellipse:
                            Diamond()
                                .stroke(shapeColor,lineWidth: 2)
                                .background(Diamond().foregroundColor(shapeColor.opacity(shapeOpacity)))
                                .padding(3)
                                .aspectRatio(2, contentMode: .fit)
                        }
                    }
                }
                .padding()
            }
            .padding()
            
        }
    }
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) * 0.7
    }
    
    private let cornerRadius:CGFloat = 10
    private let edgeLineWidth:CGFloat = 3
}
