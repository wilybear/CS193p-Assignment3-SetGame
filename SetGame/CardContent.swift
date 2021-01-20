//
//  CardContent.swift
//  SetGame
//
//  Created by 김현식 on 2021/01/20.
//

import SwiftUI

struct CardContent{
    let shape:Shape
    let count: Count
    let fill: Fill
    let shapeColor : ShapeColor
    
    // Determine whether to match or not
    func isMatch(first:CardContent, second: CardContent, third:CardContent) -> (Bool){
        isContentMatch(first.shape,second.shape,third.shape) && isContentMatch(first.count,second.count,third.count) && isContentMatch(first.shapeColor,second.shapeColor,third.shapeColor) && isContentMatch(first.fill,second.fill,third.fill)
    }
    
    private func isContentMatch<T>(_ first:T,_ second:T, _ third:T) -> (Bool) where T :Equatable{
        (first == second && second == third) || (first != second && second != third && first != third)
    }
    
    
    enum Shape: CaseIterable{
        case diamond, rectangle, ellipse
    }
    
    enum Count:Int,CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Fill: Double,CaseIterable{
        case transparent = 0
        case semiTransparent = 0.2
        case filled = 1
    }
    
    enum ShapeColor: CaseIterable{
        case red, blue, green
        func color()->(Color){
            switch self {
            case .red:
                return Color.red
            case .blue:
                return Color.blue
            case .green:
                return Color.green
            }
        }
    }
}
