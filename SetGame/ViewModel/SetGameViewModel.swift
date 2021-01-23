//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by 김현식 on 2021/01/20.
//

import SwiftUI

class SetGameViewModel : ObservableObject{
    @Published private var model: SetGameModel = SetGameModel()
    init(){}
    
    // MARK: - Access to the model
    var deck: [SetGameModel.Card]{
        model.deck
    }
    var cards: [SetGameModel.Card]{
        model.cardsOnField
    }
    
    // MARK: - Intent(s)
    func choose(card: SetGameModel.Card){
        model.choose(card: card)
    }
    
    func drawThreeCards(){
        model.drawThreeCards()
    }
    
    func startNewGame(){
        model = SetGameModel()
    }
}
