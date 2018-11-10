//
//  ScrollViewController.swift
//  d03
//
//  Created by Sergiy SHILINGOV on 10/5/18.
//  Copyright © 2018 Sergiy SHILINGOV. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView : UIImageView?
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image"
        imageView = UIImageView(image: image)
        scrollView.addSubview(imageView!)
        scrollView.contentSize = (imageView?.frame.size)!
        scrollView.maximumZoomScale = 100
    }
    
    func setZoomScale() {
        
        var minZoom = min(self.view.bounds.size.width / imageView!.bounds.size.width, self.view.bounds.size.height / imageView!.bounds.size.height);
        
        if (minZoom > 1.0) {
            minZoom = 1.0;
        }
        
        scrollView.minimumZoomScale = minZoom;
        scrollView.zoomScale = minZoom;
        
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
