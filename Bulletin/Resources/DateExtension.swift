//
//  DateExtension.swift
//  Bulletin
//
//  Created by Steve Lederer on 12/31/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import Foundation

extension Date {
    var formattedAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
