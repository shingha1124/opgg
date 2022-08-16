//
//  Array+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Foundation

extension Array where Element : Equatable {
    public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
        if bounds.lowerBound > count { return [] }
        let lower = Swift.max(0, bounds.lowerBound)
        let upper = Swift.max(0, Swift.min(count, bounds.upperBound))
        return self[lower..<upper]
    }
    
    public subscript(optional index: Int) -> Element? {
        if self.count <= index {
            return nil
        }
        return self[index]
    }
}
