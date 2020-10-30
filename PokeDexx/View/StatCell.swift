//
//  StatCell.swift
//  PokeDexx
//
//  Created by mac on 30/10/20.
//  Copyright © 2020 Jenifer. All rights reserved.
//

import UIKit

final class StatCell: UICollectionViewCell {

    @IBOutlet private weak var statLabel: UILabel!
    @IBOutlet private weak var statAmountView: UIView!
    @IBOutlet private weak var statAmountWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var statCount: UILabel!
    
    func config(stat: [String: Int]) {
        guard let statValue = stat.values.first else {
            return
        }
        statLabel.text = stat.keys.first
        statCount.text = "\(statValue)/100"
        statAmountWidthConstraint.constant = CGFloat(statValue)
    }
}
