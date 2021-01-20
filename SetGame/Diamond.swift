//
//  Pie.swift
//  Memorize_C193
//
//  Created by 김현식 on 2021/01/17.
//

import SwiftUI

struct Diamond: Shape { //Shape already has Animatable
    //rect in which where we're supposed to fit out Shape
    func path(in rect: CGRect) -> Path {
        let topCenter = CGPoint(x: rect.midX, y: rect.minY)
        let bottomCenter = CGPoint(x: rect.midX, y: rect.maxY)
        let leftCenter = CGPoint(x: rect.minX, y: rect.midY)
        let rightCenter = CGPoint(x: rect.maxX, y: rect.midY)
        //CG : Core Grapics
        var p = Path()
        p.move(to: topCenter)
        p.addLine(to: leftCenter)
        p.addLine(to: bottomCenter)
        p.addLine(to: rightCenter)
        p.addLine(to: topCenter)
        return p
    }
}
