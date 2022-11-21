//
//  RoundButton.swift
//  Calculator
//
//  Created by Kay on 2022/11/22.
//

import UIKit

// MARK: - 기존 UIButton 속성을 그대로 사용할 수 있고 추가적으로 사용자가 원하는 속성을 추가할 수 있다.
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
