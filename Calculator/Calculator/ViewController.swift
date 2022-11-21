//
//  ViewController.swift
//  Calculator
//
//  Created by Kay on 2022/11/21.
//

import UIKit

enum Operation {
    case Plus
    case Minus
    case Multiply
    case Divide
    case Unknown
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOutputLabel: UILabel!
    
    var displayNumber = ""  // 계산기 버튼을 누를때마다 numberOutputLabel에 보여질 글자
    var firstOperand = ""   // 첫번째 피연산자
    var secondOperand = ""  // 두번째 피연산자
    var result = ""         // 계산의 결과값 저장
    var currentOperation: Operation = .Unknown

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapNumberPad(_ sender: UIButton) {
        guard let number = sender.title(for: .normal) else { return }
        if displayNumber.count < 9 {    // 만약 보여질 글자가 9자 미만이라면
            displayNumber += number
            numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapDividePad(_ sender: UIButton) {
        operation(.Divide)
    }
    
    @IBAction func tapMultiplyPad(_ sender: UIButton) {
        operation(.Multiply)
    }
    
    @IBAction func tapMinusPad(_ sender: UIButton) {
        operation(.Minus)
    }
    
    @IBAction func tapPlusPad(_ sender: UIButton) {
        operation(.Plus)
    }
    
    @IBAction func tapEqualPad(_ sender: UIButton) {
        operation(currentOperation)
    }
    
    @IBAction func tapClearPad(_ sender: UIButton) {
        displayNumber = ""
        firstOperand = ""
        secondOperand = ""
        result = ""
        currentOperation = .Unknown
        numberOutputLabel.text = "0"
    }
    
    @IBAction func tapDotPad(_ sender: UIButton) {
        if displayNumber.count < 8, !displayNumber.contains(".") {  // 보여질 숫자가 8자 미만이고 또는 .을 포함하고 있지 않으면
            displayNumber += displayNumber.isEmpty ? "0." : "."
            numberOutputLabel.text = displayNumber
        }
    }
    
    func operation(_ operation: Operation) {
        if currentOperation != .Unknown {
            if !displayNumber.isEmpty {
                secondOperand = displayNumber
                displayNumber = ""
                
                guard let firstOperand = Double(firstOperand) else { return }
                guard let secondOperand = Double(secondOperand) else {
                    return }
                switch currentOperation {
                case .Plus:
                    result = "\(firstOperand + secondOperand)"
                case .Minus:
                    result = "\(firstOperand - secondOperand)"
                case .Multiply:
                    result = "\(firstOperand * secondOperand)"
                case .Divide:
                    result = "\(firstOperand / secondOperand)"
                default:
                    break
                }
                
                if let result = Double(result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                
                self.firstOperand = result
                self.numberOutputLabel.text = result
            }
        } else {
            firstOperand = displayNumber
            displayNumber = ""
        }
        currentOperation = operation
    }
}

