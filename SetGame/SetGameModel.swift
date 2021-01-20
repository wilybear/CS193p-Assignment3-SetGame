//
//  Model.swift
//  SetGame
//
//  Created by 김현식 on 2021/01/20.
//

import Foundation

struct SetGameModel{
    private(set) var deck:[Card]
    private(set) var cardsOnField:[Card]
    
    
    init(){
        deck = [Card]()
        cardsOnField = [Card]()
        var id = 0
        // put every cases into deck
        for shape in CardContent.Shape.allCases{
            for count in CardContent.Count.allCases{
                for color in CardContent.ShapeColor.allCases{
                    for fill in CardContent.Fill.allCases{
                        deck.append(Card(id: id, cardContent: CardContent(shape: shape, count: count, fill: fill, shapeColor: color)))
                        id += 1
                    }
                }
            }
        }
        deck.shuffle()
        // get 12 cards from deck and remove it
        for _ in 0..<12{
            cardsOnField.append(deck.removeFirst())
        }
    }
    
    mutating func choose(card: Card){
        print(card)
    }
    
    struct Card: Identifiable{
        var id: Int
        var cardContent : CardContent
        var isSelected : Bool = false
        var isMatched :Bool = false
    }
}
