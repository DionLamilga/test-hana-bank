//
//  CardCell.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit
import Kingfisher
import SkeletonView

class CardCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var evolveLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    static let identifier = String(describing: CardCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray.cgColor
        showSkeleton()
        super.awakeFromNib()
    }

    func setupCell(data: PokemonCard) {
        let url = data.images?.large ?? ""
        cardImage.kf.setImage(with: URL(string: url))
        nameLabel.text = "Name: \(data.name ?? "")"
        typeLabel.text = "Types: \(data.types?.joined(separator: ",") ?? "")"
        evolveLabel.text = "Evolve Form: \(data.evolvesFrom ?? "-")"
    }
    
    func showSkeleton() {
        cardImage.showAnimatedGradientSkeleton()
        nameLabel.showAnimatedGradientSkeleton()
        typeLabel.showAnimatedGradientSkeleton()
        evolveLabel.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        cardImage.hideSkeleton()
        nameLabel.hideSkeleton()
        typeLabel.hideSkeleton()
        evolveLabel.hideSkeleton()
    }
}
