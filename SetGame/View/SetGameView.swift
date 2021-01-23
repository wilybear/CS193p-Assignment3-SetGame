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
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Button(action: {
                        withAnimation(.easeInOut(duration:1)){
                            viewModel.startNewGame()
                        }
                    }, label: {
                        Text("New Game").font(.title)
                    }).frame(width: geometry.size.width/2)

                    Button(action: {
                        withAnimation(.easeInOut(duration:0.8)){
                            viewModel.drawThreeCards()
                        }
                    }, label: {
                        Text("Draw").font(.title)
                    }).frame(width: geometry.size.width/2)
                 
                }.fixedSize()
                Grid(viewModel.cards){ card in
                    CardView(card: card).onTapGesture{
                        withAnimation(.easeInOut(duration: 0.8)){
                            viewModel.choose(card: card)
                        }
                    }
                    .aspectRatio(0.75, contentMode: .fit)
                    .scaleEffect(card.isSelected ? 1.05 : 1)
                    .transition(AnyTransition.offset(locationRandomizer(for: CGSize(width: geometry.size.width, height: geometry.size.height))))

                }  .onAppear{
                    withAnimation(.easeInOut(duration:0.8)){
                        viewModel.startNewGame()
                    }
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

// Card View
struct CardView: View{
    var card : SetGameModel.Card
    var lineColor : Color{
        if !card.isMatched{
            return card.isSelected ? Color.blue : Color.black
        }
        return Color.green
    }
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
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineColor, lineWidth: edgeLineWidth)
                    .shadow(color: Color.gray, radius: 3, x: 1, y: 2)
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

//source from https://github.com/vaIerika/stanford2020/blob/master/SetGame/SetGame/View/ContentView.swift
private func locationRandomizer(for canvas: CGSize) -> CGSize {
    
    // Random coordimates out of the canvas
    let widthRange = [
        -Int(canvas.width * 1.5) ..<
        -Int(canvas.width * 1.25),
        Int(canvas.width * 1.25) ..<
        Int(canvas.width * 1.5)
    ].shuffled()
    
    let heightRange = [
        -Int(canvas.height * 1.5) ..<
        -Int(canvas.height * 1.25),
        Int(canvas.height * 1.25) ..<
        Int(canvas.height * 1.5)
    ].shuffled()
    
    let randomLocation = CGSize(width: Int.random(in: widthRange[0]),
                                height: Int.random(in: heightRange[0]))
    return randomLocation
}
