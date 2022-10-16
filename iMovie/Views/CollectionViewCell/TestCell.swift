//
//  TestCell.swift
//  iMovie
//
//  Created by Sandesh Naik on 11/09/22.
//  Copyright © 2022 sandesh. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    static let identifier = "test-cell"
    
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
