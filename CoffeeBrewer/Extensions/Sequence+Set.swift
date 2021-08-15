//
//  Sequence+Set.swift
//  Sequence+Set
//
//  Created by Nguyen Tran Duy Khang on 8/15/21.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen = Set<Iterator.Element>()
        return self.filter { seen.insert($0).inserted }
    }
}
