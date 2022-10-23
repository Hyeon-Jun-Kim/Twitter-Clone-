//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 김현준 on 2022/10/23.
//

import Foundation
import UIKit

class TweetCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
