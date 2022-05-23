//
//  ContentView.swift
//  calculator
//
//  Created by Szymon Kaszuba-Gałka on 22/05/2022.
//

import SwiftUI

enum MyError: Error {
    case BadConversion
}

enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case equals = "="
    case add = "+"
    case substract = "-"
    case multiply = "x"
    case divide = "/"
    case leftBrace = "("
    case rightBrace = ")"
    case decimal = "."
    case clear = "AC"
    
    var buttonColor: Color {
        switch self {
        case .equals, .add, .substract, .multiply, .divide:
            return Color(.orange)
        case .leftBrace, .rightBrace, .clear:
            return Color(.lightGray)
        default:
            return Color(
                UIColor(
                    red: 55/255.0,
                    green: 55/255.0,
                    blue: 55/255.0,
                    alpha: 1.0
                )
            )
        }
    }
}

struct ContentView: View {
    @State var expression: String = "0"
    @State var result: String = ""

    let numbersStrings = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .leftBrace, .rightBrace, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                // Text display
                ScrollView(.horizontal) {
                    ScrollViewReader { reader in
                        HStack {
                            Text(expression)
                                .bold()
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .padding()
                                .id("expression")
                                
                        }.onChange(of: expression) { newValue in
                            withAnimation {
                                reader.scrollTo("expression", anchor: .trailing)
                            }
                        }
                    }
                }
                
                Spacer()
                
                ScrollView(.horizontal) {
                    ScrollViewReader { reader in
                        HStack {
                            Text(result)
                                .bold()
                                .font(.system(size: 100))
                                .foregroundColor(.white)
                                .padding()
                                .id("result")
                        }.onChange(of: result) { newValue in
                            withAnimation {
                                reader.scrollTo("result", anchor: .trailing)
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Buttons
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.onButtonPress(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor
                                    )
                                    .foregroundColor(.white)
                                    .font(.system(size: self.buttonHeight() / 2))
                                    .cornerRadius(self.buttonHeight() / 2)
                            })
                        }
                    }
                }
            }
        }
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if (item == .zero) {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func unwrapFloat(potentialNumber: String) throws -> Float {
        let val = Float(potentialNumber)
        if (val != nil) {
            return val!
        } else {
            throw MyError.BadConversion
        }
    }
    
    func unwrapInt(floatNumber: Float) throws {
        let val = Int(floatNumber)
        if (Float(val) == floatNumber) {
            return
        } else {
            throw MyError.BadConversion
        }
    }
    
    func isInt(number: Float) -> Bool {
        do {
            try unwrapInt(floatNumber: number)
            return true
        } catch {
            return false
        }
    }
    
    func onButtonPress(button: CalculatorButton) {
        let potentialNumbers: [String] = expression.components(
            separatedBy: CharacterSet(charactersIn: "()/x-*+")
        )
        var numbers: [Float] = []
        for potentialNumber in potentialNumbers {
            if(potentialNumber != "") {
                do {
                    try numbers.append(self.unwrapFloat(potentialNumber: potentialNumber))
                } catch {
                    // TODO: Create error handling (display snackBar with error info)
                    expression = "0"
                }
            }
        }
        
        switch button {
        case .equals:
            // TODO: Implement Djikstra's Shunting Yard algorithm
            break
        case .clear:
            expression = "0"
            break
        case .decimal:
            if (numbersStrings.contains(String(expression.last!)) &&
                isInt(number: numbers[numbers.endIndex - 1])) {
                expression = "\(expression)\(button.rawValue)"
            }
            break
        default:
            if (expression == "0") {
                expression = "\(button.rawValue)"
            } else {
                expression = "\(expression)\(button.rawValue)"
            }
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
