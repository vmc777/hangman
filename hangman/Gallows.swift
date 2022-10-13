//
//  buildHangingFrame.swift
//  hangman
//
//  Created by VerDel Cargal on 10/8/22.
//

import SwiftUI

struct Gallows: Shape {
    let guessesRemaining: Int
     
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var guessesCutoff = HangmanGame.INCORRECT_GUESSES_ALLOWED
        
        let height = rect.height
        let width = rect.width

        let lengthOfRope = height * 0.15
        let ropeX = width * 0.4
         
        let headRadius = height * 0.06
        let torsoHeight = height * 0.20
        
        let endOfRope = CGPoint(x: ropeX, y: lengthOfRope)
        let bottomOfHead = CGPoint(
            x: endOfRope.x,
            y: endOfRope.y + (headRadius * 2))
        let bottomOfTorso = CGPoint(
            x: bottomOfHead.x,
            y: bottomOfHead.y + torsoHeight)
            
        addGallows()
        addHead()
        addTorso()
        addArms()
        addLegs()
        addEyes()
        addMouth()
        return path
        
        func addGallows() {
            let poleX = width * 0.8
            let bottomOfPole = CGPoint(x: poleX, y: height)
            let topOfPole = CGPoint(x: bottomOfPole.x, y: rect.minY)
            let endOfCrossBar = CGPoint(x: ropeX, y: topOfPole.y)

            path.move(to: bottomOfPole)
            path.addLine(to: topOfPole)
            path.addLine(to: endOfCrossBar)
            path.addLine(to: endOfRope)
 
            let baseRight = CGPoint(x: width, y: height)
            let baseLeft = CGPoint(x: rect.minX, y: baseRight.y)
     
            path.move(to: baseLeft)
            path.addLine(to: baseRight)
        }
        
        func addHead() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
            
            path.move(to: endOfRope)
            path.addArc(
                center: CGPoint(
                    x: endOfRope.x,
                    y: endOfRope.y + headRadius),
                radius: headRadius,
                startAngle: .degrees(270),
                endAngle: .degrees(270 - 360),
                clockwise: false
            )
        }
        
        func addTorso() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
            
            path.move(to: bottomOfHead)
            path.addLine(to: bottomOfTorso)
        }
        
        func addArms() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
            
            let armLength = height * 0.15
            let armAngle = deg2rad(50)
            
            let shoulders = CGPoint(
                x: bottomOfHead.x,
                y: bottomOfHead.y + headRadius / 2)
            let handXDelta = cos(armAngle) * armLength
            let handY = shoulders.y + (sin(armAngle) * armLength)
            let leftHandX = shoulders.x - handXDelta
            let rightHandX = shoulders.x + handXDelta
            
            path.move(to: shoulders)
            path.addLine(to: CGPoint(x: leftHandX, y: handY))
            path.move(to: shoulders)
            path.addLine(to: CGPoint(x: rightHandX, y: handY))
        }
        
        func addLegs() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
            
            let legLength = height * 0.30
            let legAngle = deg2rad(70)

            let footXDelta = cos(legAngle) * legLength
            let footY = bottomOfTorso.y + (sin(legAngle) * legLength)
            let leftFootX = bottomOfTorso.x - footXDelta
            let rightFootX = bottomOfTorso.x + footXDelta
            
            path.move(to: bottomOfTorso)
            path.addLine(to: CGPoint(x: leftFootX, y: footY))
            path.move(to: bottomOfTorso)
            path.addLine(to: CGPoint(x: rightFootX, y: footY))
        }
        
        func addEyes() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
  
            let eyeXDelta = headRadius * 0.3
            let eyeY = endOfRope.y + headRadius * 0.8
            let eyeRadius = headRadius * 0.1
     
            let leftEyeX = endOfRope.x - eyeXDelta
            let rightEyeX = endOfRope.x + eyeXDelta
            
            path.move(to: CGPoint(x: rightEyeX, y: eyeY - eyeRadius))
            path.addArc(
                center: CGPoint(x: rightEyeX, y: eyeY),
                radius: eyeRadius,
                startAngle: .degrees(270),
                endAngle: .degrees(270 - 360),
                clockwise: false
            )
            path.move(to: CGPoint(x: leftEyeX, y: eyeY - eyeRadius))
            path.addArc(
                center: CGPoint(x: leftEyeX, y: eyeY),
                radius: eyeRadius,
                startAngle: .degrees(270),
                endAngle: .degrees(270 - 360),
                clockwise: false
            )
        }
        
        func addMouth() {
            if guessesRemaining >= guessesCutoff { return }
            guessesCutoff -= 1
            
            let mouthRadius = headRadius * 0.2
      
            let mouthCenter = CGPoint(x: bottomOfHead.x, y: bottomOfHead.y - mouthRadius * 2)
            
            path.move(to: CGPoint(x: bottomOfHead.x + mouthRadius, y: mouthCenter.y))
            path.addArc(center: mouthCenter,
                        radius: mouthRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(180),
                        clockwise: true)
        }
    }

    func deg2rad(_ number: Double) -> Double {
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
                .stroke(.red, lineWidth: 1)
                .frame(width: 70.0, height: 130.0)
                .background(.green)
            Spacer()
        }
    }
}