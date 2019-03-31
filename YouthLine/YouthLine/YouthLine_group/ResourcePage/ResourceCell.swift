//
//  ResourceCell.swift
//  YouthLine
//
//  Created by Yuting Shao on 2019-03-10.
//  Copyright © 2019 RainbowWarrior. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    var minHeight: CGFloat?
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }
    
    var ResourceTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VAGRoundedStd-Bold", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    var footerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "VAGRoundedStd-thin", size: 14)
        label.textColor = RGBColor(150, 150, 150)
        return label
    }()
    
    var ResourceImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(ResourceTitleLabel)
        ResourceTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.top.equalTo(self.contentView).offset(12)
            make.right.equalToSuperview().offset(-150)
        }
        
        contentView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(ResourceTitleLabel.snp.bottom).offset(10)
            make.right.equalTo(ResourceTitleLabel).offset(0)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        contentView.addSubview(ResourceImgView)
        ResourceImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(140)
            make.height.equalTo(65)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setImage(resource: Resource) {
//        if resource.image.size.width > 140 {
//            let size = CGSize(width: 140, height: max(65, 140 * resource.image.size.height / resource.image.size.width))
//            ResourceImgView.image = resource.image.scaledAspectFit(to: size)
//        } else {
//            ResourceImgView.image = resource.image
//        }
        let url = URL(string: resource.image)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            // Finally convert that Data into an image and do what you wish with it.
            let image = UIImage(data: imageData)
            ResourceImgView.image = image
            // Do something with your image.
        } else {
            print("Couldn't get image: Image is nil")
        }
//        ResourceImgView.image = resource.image
        ResourceTitleLabel.text = resource.title
    }
    
}

//extension UIImage {
//
//    /// Resize the image to be the required size, stretching it as needed.
//    ///
//    /// - parameter newSize:      The new size of the image.
//    /// - parameter contentMode:  The `UIViewContentMode` to be applied when resizing image.
//    ///                           Either `.scaleToFill`, `.scaleAspectFill`, or `.scaleAspectFit`.
//    ///
//    /// - returns:                Return `UIImage` of resized image.
//
//    func scaled(to newSize: CGSize, contentMode: UIViewContentMode = .scaleToFill) -> UIImage? {
//        if contentMode == .scaleToFill {
//            return filled(to: newSize)
//        } else if contentMode == .scaleAspectFill || contentMode == .scaleAspectFit {
//            let horizontalRatio = size.width  / newSize.width
//            let verticalRatio   = size.height / newSize.height
//
//            let ratio: CGFloat!
//            if contentMode == .scaleAspectFill {
//                ratio = min(horizontalRatio, verticalRatio)
//            } else {
//                ratio = max(horizontalRatio, verticalRatio)
//            }
//
//            let sizeForAspectScale = CGSize(width: size.width / ratio, height: size.height / ratio)
//            let image = filled(to: sizeForAspectScale)
//            if contentMode == .scaleAspectFill {
//                let subRect = CGRect(
//                    x: floor((sizeForAspectScale.width - newSize.width) / 2.0),
//                    y: floor((sizeForAspectScale.height - newSize.height) / 2.0),
//                    width: newSize.width,
//                    height: newSize.height)
//                return image?.cropped(to: subRect)
//            }
//            return image
//        }
//        return nil
//    }
//
//    /// Resize the image to be the required size, stretching it as needed.
//    ///
//    /// - parameter newSize:   The new size of the image.
//    ///
//    /// - returns:             Resized `UIImage` of resized image.
//
//    func filled(to newSize: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
//        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return image
//    }
//
//    /// Crop the image to be the required size.
//    ///
//    /// - parameter bounds:    The bounds to which the new image should be cropped.
//    ///
//    /// - returns:             Cropped `UIImage`.
//
//    func cropped(to bounds: CGRect) -> UIImage? {
//        var rect = bounds
//        rect.size.width *= scale
//        rect.size.height *= scale
//
//        if let imageRef = cgImage?.cropping(to: rect) {
//            return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
//        } else {
//            return nil
//        }
//    }
//
//    /// Resize the image to fill the rectange of the specified size, preserving the aspect ratio, trimming if needed.
//    ///
//    /// - parameter newSize:   The new size of the image.
//    ///
//    /// - returns:             Return `UIImage` of resized image.
//
//    func scaledAspectFill(to newSize: CGSize) -> UIImage? {
//        return scaled(to: newSize, contentMode: .scaleAspectFill);
//    }
//
//    /// Resize the image to fit within the required size, preserving the aspect ratio, with no trimming taking place.
//    ///
//    /// - parameter newSize:   The new size of the image.
//    ///
//    /// - returns:             Return `UIImage` of resized image.
//
//    func scaledAspectFit(to newSize: CGSize) -> UIImage? {
//        return scaled(to: newSize, contentMode: .scaleAspectFit)
//    }
//
//}
