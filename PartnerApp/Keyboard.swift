//  Tự động ẩn bàn phím ảo khi người dùng ấn vào bất cứ khu vực nào của màn hình.
//  Created by HoiHD on 10/02/2022.

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard));
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap);
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true);
    }
}
