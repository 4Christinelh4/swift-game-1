//
//  Pie.swift
//  Memorize Game (iOS)
//
//  Created by yuweiL on 25/6/2024.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = Angle.zero
    let endAngle: Angle
    let clockwise = true
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians))
        print(center)
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise:  clockwise)
        
        p.addLine(to: center)
        return p
    }
}

#Preview {
    Pie(endAngle: Angle(degrees: 270))
}
