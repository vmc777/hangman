//
//  buildHangingFrame.swift
//  hangman
//
//  Created by VerDel Cargal on 10/8/22.
//

import SwiftUI

struct Gallows: Shape {
    let guessesRemaining: Int
    
    let poleX = 0.8
    let headRadiusPct = 0.06
    let ropeX = 0.4
    let lengthOfRope = 0.15
    let torsoHeight = 0.20
    let leglength = 0.30
    let legAngle = deg2rad(70.0)
    let armLength = 0.15
    let armAngle = deg2rad(50.0)
    let eyeXPercent = 0.3
    let eyeYPercent = 0.8
    let eyeRadiusPercent = 0.10
    let mouthRadiusPercent = 0.2
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let bottomOfPole = CGPoint(x: rect.width * poleX, y: rect.maxY)
            let topOfPole = CGPoint(x: bottomOfPole.x, y: rect.minY)
            let endOfCrossBar = CGPoint(x: rect.width * ropeX, y: topOfPole.y)
            let baseRight = CGPoint(x: rect.maxX, y: rect.maxY)
            let baseLeft = CGPoint(x: rect.minX, y: baseRight.y)
            
            path.move(to: bottomOfPole)
            path.addLine(to: topOfPole)
            path.addLine(to: endOfCrossBar)
            path.addLine(to: endOfRope(rect))
            
            path.move(to: baseLeft)
            path.addLine(to: baseRight)
            
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED { return }
            addHead(&path, rect)
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED - 1 { return }
            addTorso(&path, rect)
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED - 2 { return }
            addArms(&path, rect)
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED - 3 { return }
            addLegs(&path, rect)
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED - 4 { return }
            addEyes(&path, rect)
            if guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED - 5 { return }
            addMouth(&path, rect)
        }
    }
    
    private func addHead(_ path: inout Path, _ rect: CGRect) {
        let radius = rect.height * headRadiusPct
        let endOfRope = endOfRope(rect)
        
        path.move(to: endOfRope)
        path.addArc(
            center: CGPoint(x: endOfRope.x, y: endOfRope.y + radius),
            radius: radius,
            startAngle: .degrees(270),
            endAngle: .degrees(270 - 360),
            clockwise: false
        )
    }
    
    private func addTorso(_ path: inout Path, _ rect: CGRect) {
        path.move(to: bottomOfHead(rect))
        path.addLine(to: bottomOfTorso(rect))
    }
    
    private func addArms(_ path: inout Path, _ rect: CGRect) {
        let bottomOfHead = bottomOfHead(rect)
        let shoulders = CGPoint(x: bottomOfHead.x, y: bottomOfHead.y + rect.height * headRadiusPct / 2)

        let handXDelta = cos(armAngle) * (rect.height * armLength)
        let handY = shoulders.y + sin(armAngle) * rect.height * armLength
        
        path.move(to: shoulders)
        path.addLine(to: CGPoint(x: shoulders.x - handXDelta, y: handY))
        path.move(to: shoulders)
        path.addLine(to: CGPoint(x: shoulders.x + handXDelta, y: handY))
    }
    
    private func addLegs(_ path: inout Path, _ rect: CGRect) {
        let bottomOfTorso = bottomOfTorso(rect)
        let footXDelta = cos(legAngle) * (rect.height * leglength)
        let footY = bottomOfTorso.y + sin(legAngle) * rect.height * leglength
        
        path.move(to: bottomOfTorso)
        path.addLine(to: CGPoint(x: bottomOfTorso.x - footXDelta, y: footY))
        path.move(to: bottomOfTorso)
        path.addLine(to: CGPoint(x: bottomOfTorso.x + footXDelta, y: footY))
    }
    
    private func addEyes(_ path: inout Path, _ rect: CGRect) {
        let endOfRope = endOfRope(rect)
        let headRadius = rect.height * headRadiusPct
        let eyeXDelta = headRadius * eyeXPercent
        let eyeY = endOfRope.y + headRadius * eyeYPercent
        let leftEyeX = endOfRope.x - eyeXDelta
        let rightEyeX = endOfRope.x + eyeXDelta
        
        path.move(to: CGPoint(x: rightEyeX, y: eyeY - headRadius * eyeRadiusPercent))
        path.addArc(
            center: CGPoint(x: rightEyeX, y: eyeY),
            radius: headRadius * eyeRadiusPercent,
            startAngle: .degrees(270),
            endAngle: .degrees(270 - 360),
            clockwise: false
        )
        path.move(to: CGPoint(x: leftEyeX, y: eyeY - headRadius * eyeRadiusPercent))
        path.addArc(
            center: CGPoint(x: leftEyeX, y: eyeY),
            radius: headRadius * eyeRadiusPercent,
            startAngle: .degrees(270),
            endAngle: .degrees(270 - 360),
            clockwise: false
        )
    }
    
    private func addMouth(_ path: inout Path, _ rect: CGRect) {
        let headRadius = rect.height * headRadiusPct
        let bottomOfHead = bottomOfHead(rect)
        let mouthRadius =  headRadius * mouthRadiusPercent
        let mouthCenter = CGPoint(x: bottomOfHead.x, y: bottomOfHead.y - mouthRadius * 2)
        
        path.move(to: CGPoint(x: bottomOfHead.x + mouthRadius, y: mouthCenter.y))
        path.addArc(center: mouthCenter,
                    radius: mouthRadius,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: true)
    }
    
    private func endOfRope(_ rect: CGRect) -> CGPoint {
        CGPoint(x: rect.width * ropeX, y: rect.height * lengthOfRope)
    }
    
    private func bottomOfHead(_ rect: CGRect) -> CGPoint {
        CGPoint(x: endOfRope(rect).x,
                y: endOfRope(rect).y + (rect.height * headRadiusPct * 2))
    }

    private func bottomOfTorso(_ rect: CGRect) -> CGPoint {
        CGPoint(x: bottomOfHead(rect).x, y: bottomOfHead(rect).y + rect.height * torsoHeight)
    }

    static func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
}

struct Gallows_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            Gallows(guessesRemaining: 0)
                .stroke(.red, lineWidth: 3)
                .frame(width: 300.0, height: 400.0)
                .background(.yellow)
            Spacer()
            Gallows(guessesRemaining: 0)
                .stroke(.red, lineWidth: 3)
                .frame(width: 70.0, height: 130.0)
                .background(.green)
            Spacer()
        }
    }
}
