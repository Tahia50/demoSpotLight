//
//  StringExtension.swift
//  Test
//
//  Created by Tahia Ata on 11/3/16.
//  Copyright © 2016 Tahia Ata. All rights reserved.
//

import Foundation

extension String {
    func stringByAppendingPathComponent(path: String) -> String {

        let nsSt = self as NSString

        return nsSt.stringByAppendingPathComponent(path)
    }

}
