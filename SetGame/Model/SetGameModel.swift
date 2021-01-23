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
    
    private var indicesOfSelectedCards : [Int] {
        get{
            cardsOnField.indices.filter{cardsOnField[$0].isSelected}
        }
        set{
            for index in newValue{
                cardsOnField[index].isSelected = true
            }
        }
    }
    
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
        if let choosenIndex = cardsOnField.firstIndex(matching: card), !cardsOnField[choosenIndex].isMatched{
            if !cardsOnField[choosenIndex].isSelected{
                cardsOnField[choosenIndex].isSelected = true
                if indicesOfSelectedCards.count == 3{
                    if isMatch(indicesOfSelectedCards: indicesOfSelectedCards){
                        for index in indicesOfSelectedCards{
                            cardsOnField[index].isMatched = true
                        }
                    }else{
                        for index in indicesOfSelectedCards{
                            cardsOnField[index].isSelected = false
                        }
                    }
                }
            }else{
                cardsOnField[choosenIndex].isSelected = false
            }
            cardsOnField.removeAll(where: {$0.isMatched})

        }
    }
    
    mutating func drawThreeCards(){
        if !deck.isEmpty , cardsOnField.count <= 21 {
            for _ in 0..<3{
                cardsOnField.append(deck.removeFirst())
            }
        }
    }
    
    func isMatch(indicesOfSelectedCards :[Int]) -> (Bool){
        CardContent.isMatch(first: cardsOnField[indicesOfSelectedCards[0]].cardContent, second: cardsOnField[indicesOfSelectedCards[1]].cardContent, third: cardsOnField[indicesOfSelectedCards[2]].cardContent)
    }
    
    struct Card: Identifiable{
        var id: Int
        var cardContent : CardContent
        var isSelected : Bool = false
        var isMatched :Bool = false
    }
}
