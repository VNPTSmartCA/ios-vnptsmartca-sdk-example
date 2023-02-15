//
//  ViewController.swift
//  Partner
//
//  Created by Pham Tu on 13/10/2022.
//

import UIKit
import FinalSDK
import VnptSmartCAFramework

//,  ICEkycCameraDelegate
class ViewController: UIViewController{
    @IBOutlet weak var btnActivate: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var txtTranID: UITextField!
    @IBOutlet weak var btnMainInfo: UIButton!
    
    var vnptSmartCASDK: VNPTSmartCASDK!;
    var tranId: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.hideKeyboardWhenTappedAround();
        
        self.vnptSmartCASDK = VNPTSmartCASDK(
            viewController:  self,
            partnerId: "CLIENT_ID",
            environment: VNPTSmartCASDK.ENVIRONMENT.DEMO,
            lang: VNPTSmartCASDK.LANG.VI);
        
        self.btnConfirm.addTarget(self, action: #selector(getWaitingTransaction), for: .touchUpInside);
        self.btnActivate!.addTarget(self, action: #selector(getAuthentication), for: .touchUpInside);
        self.btnMainInfo!.addTarget(self, action: #selector(getMainInfo), for: .touchUpInside);
     
    }
    
    // Lấy thông tin về AccessToken & Credential
    @objc func getAuthentication() {
        // SDK tự động xử lý các trường hợp về token: Hết hạn, chưa kích hoạt...
        self.vnptSmartCASDK.getAuthentication(callback: {authResult in
            if authResult.status == SmartCAResultCode.SUCCESS_CODE {
                print(authResult.data)
            } else {
                // SDK tự động hiển thị giao diện
            }
        });
    }
    
    @objc func  getMainInfo(){
        self.vnptSmartCASDK.getMainInfo(callback: {result in
            print(result)
        })
    }
    
    // Khách hàng xác nhận / hủy giao dịch.
    @objc func getWaitingTransaction() {
        if self.txtTranID.text != "" {
            self.tranId = self.txtTranID.text!;
            
            self.vnptSmartCASDK.getWaitingTransaction(tranId: self.tranId, callback: { wtResult in
                if wtResult.status == SmartCAResultCode.SUCCESS_CODE {
                    print("Giao dịch thành công: \(wtResult.status) - \(wtResult.statusDesc) - \(wtResult.data)");
                } else {
                    print("Lỗi giao dịch: \(wtResult.status) - \(wtResult.statusDesc) - \(wtResult.data)");
                }
            });
            
        } else {
            print("Vui lòng nhập dữ liệu")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.vnptSmartCASDK.destroySDK();
    }
}
 
extension ViewController: ICEkycCameraDelegate{
    func ekycNetworkDidCallApi() {
        //
    }

    func getResult() {
        self.vnptSmartCASDK.getResulteKYC();
    }
}
 
