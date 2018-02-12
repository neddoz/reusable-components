//
//  RatingView.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 08/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class RatingView: UIView {

    // MARK: Properties
    var rating = 0 {
        didSet{
            updateState()
        }
    }

    // MARK: private properties
    private var ratingButtons:[UIButton] = []

    // MARK: Outlets
    @IBOutlet weak var first: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var third: UIButton!
    @IBOutlet weak var fourth: UIButton!
    @IBOutlet weak var fifth: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        ratingButtons = [first, second, third, fourth, fifth]
        setUpButtons()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Private functions
    private func updateState(){
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }

    private func setUpButtons(){
        for button in self.ratingButtons {
            button.setImage(#imageLiteral(resourceName: "filledStar"), for: .selected)
            button.setImage(#imageLiteral(resourceName: "emptyStar"), for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        }
        updateState()
    }

    @objc func buttonTapped(button: UIButton){
        guard let index = self.ratingButtons.index(of: button) else { return }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
