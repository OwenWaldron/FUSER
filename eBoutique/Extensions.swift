//
//  Extensions.swift
//  eBoutique
//
//  Created by Janvier Rugomoka Zagabe on 2021-05-19.
//

import Foundation
extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
