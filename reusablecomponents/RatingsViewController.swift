//
//  RatingsViewController.swift
//  reusablecomponents
//
//  Created by kayeli dennis on 09/02/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class RatingsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var mealName: UILabel!

    //MARK: Private types
    private enum ConstraintAttribute: String {
        case top
        case left
    }

    //MARK: Instance properties
    public var mealItems: [Meal]?

    // MARK: private properties
    private var currentratingView: RatingView!
    private var nextratingView: RatingView!
    private var previousratingView: RatingView!
    private var mealIndex = 0 {
        didSet{}
    }

    private var currentLeftConstraint: NSLayoutConstraint!
    private var previousLeftConstraint: NSLayoutConstraint!
    private var nextLeftConstraint: NSLayoutConstraint!

    private let currentLeftOffset: CGFloat = 20
    private let nextLeftOffset: CGFloat = 344
    private let previousLeftOffset: CGFloat = -316

    private lazy var ratingNib = UINib(nibName: "ratingsView", bundle: nil)

    override func viewDidLoad() {
        guard let current = loadRatingView(),
            let next = loadRatingView(),
            let previous = loadRatingView() else { return }
        super.viewDidLoad()

        currentratingView = current
        nextratingView = next
        previousratingView = previous

        currentratingView.delegate = self
        nextratingView.delegate = self
        previousratingView.delegate = self

        // Top Constraints for our rating views
        activateTopConstraint(for: currentratingView)
        activateTopConstraint(for: nextratingView)
        activateTopConstraint(for: previousratingView)

        // Left Constraints for our rating Views
        currentLeftConstraint = activateLeftConstraint(for: currentratingView, leftOffset: currentLeftOffset)
        nextLeftConstraint = activateLeftConstraint(for: nextratingView, leftOffset: nextLeftOffset)
        previousLeftConstraint = activateLeftConstraint(for: previousratingView, leftOffset: previousLeftOffset)

        // Bind Data
        bindView()
    }

    // MARK: private methods
    private func loadRatingView()-> RatingView?{
        guard let currentratingView = ratingNib.instantiate(withOwner: self,
                                                     options: nil).first as? RatingView else { return nil }
        view.addSubview(currentratingView)
        return currentratingView
    }

    private func activateTopConstraint(`for` ratingView: UIView){
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        let constant: CGFloat = 203
        NSLayoutConstraint(item: ratingView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }

    private func activateLeftConstraint(`for` cardView: UIView,
                                        leftOffset: CGFloat) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(item: cardView,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: self.view,
                                            attribute: .left,
                                            multiplier: 1,
                                            constant: leftOffset)

        constraint.isActive = true

        return constraint
    }

    private func bindView(){
        guard let meals = mealItems else { return }
        let currentMeal = meals[mealIndex]
        self.mealName.text = currentMeal.name
    }
}

extension RatingsViewController: RatingViewDelegate {
    func previousButtonTapped() {
        print("Yes previous tapped!")
    }

    func nextButtonTapped() {
        guard let mealItems = mealItems else { return }
        guard self.mealIndex < mealItems.count - 1 else { return }

        previousratingView.isHidden = true
        previousLeftConstraint.constant = nextLeftOffset + 336

        self.view.layoutIfNeeded()

        previousratingView.isHidden = false

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.currentLeftConstraint.constant = self.previousLeftOffset
                        self.nextLeftConstraint.constant = self.currentLeftOffset
                        self.previousLeftConstraint.constant = self.nextLeftOffset

                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        let tempView = self.currentratingView

                        self.currentratingView = self.nextratingView
                        self.nextratingView = self.previousratingView
                        self.previousratingView = tempView

                        self.currentLeftConstraint.isActive = false
                        self.nextLeftConstraint.isActive = false
                        self.previousLeftConstraint.isActive = false

                        self.setUpAnimationConstraints()

                        self.mealIndex += 1

        } )
    }

    func setUpAnimationConstraints() {
        currentLeftConstraint = activateLeftConstraint(for: currentratingView, leftOffset: currentLeftOffset)
        nextLeftConstraint = activateLeftConstraint(for: nextratingView, leftOffset: nextLeftOffset)
        previousLeftConstraint = activateLeftConstraint(for: previousratingView, leftOffset: previousLeftOffset)
    }
}
