//
//  ViewController.swift
//  AlamofirePractice
//
//  Created by photypeta-junha on 2021/09/03.
//

import UIKit
import SnapKit
import Alamofire
import MobileCoreServices

class ViewController: UIViewController {
    
    struct RequestBodyFormDataKeyValue {
        var sKey: String
        var sValue: String
        var dBlobData: Data
        var mimeType: String
    }
    
    let getRequestButton = UIButton(type: .system)
    let postRequestButton = UIButton(type: .system)
    let postFormDataButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    
    
    @objc func postFormDataButtonTap(_ sender: UIButton) {
        // Multipart: Alamofire에서 제공해주는 기능 - 이미지를 data로 전환해 전송한다.
        // multipart/form-data는 파일 업로드가 있는 양식요소에 사용되는 enctype속성의 값중 하나이고, multipart는 폼데이터가 여러 부분으로 나뉘어 서버로 전송되는 것을 의미함
        var bodyKeyValue = [RequestBodyFormDataKeyValue]()
        //        var sURL = "https://httpbin.org/post"
//        var sURL = "https://ptsv2.com/t/qpy40-1641349574/post"
//                var sURL = "http://192.168.0.28:3000/photo/upload"
        let sURL = "http://192.168.0.28:3000/photo"
        
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "a", sValue: "b", dBlobData: Data(), mimeType: ""))
        let header: HTTPHeaders = ["snsId": "1882972156"]
        //[0] Name; [1] extension
        //        var photoArray = ["iPhone1.jpg", "iPhone2.jpg", "iPhone3.jpg", "iPhone4.jpg", "iPhone5.jpg"]
        var photoArray = ["iPhone1.jpg", "iPhone2.jpg", "nlogo.png"]
        
        for file in photoArray {
            let oArrArray = file.components(separatedBy: ".")
            let oImage = UIImage(named: file)
            //            let dData = oImage?.pngData()
            let dData = oImage?.jpegData(compressionQuality: 1)
            
            
            let mimeType = self.returnMimeType(fileExtension: oArrArray[1])
            bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "filename", sValue: file, dBlobData: dData!, mimeType : "image/jpeg"))
        }
        //        let oArrArray = "iPhone2.jpg".components(separatedBy: ".")
        //        let mimeType = self.returnMimeType(fileExtension: oArrArray[1])
        //        let oImage = UIImage(named: "iPhone2.jpg")
        //        let dData = oImage?.pngData()
        
        
        //        let dData = oImage?.jpegData(compressionQuality: 1)
        
        //        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "filename", sValue: "iphone1", dBlobData: dData!))
        
    
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
        
        var  sampleRequest = URLRequest(url: URL(string: sURL)!)
        sampleRequest.httpMethod = HTTPMethod.post.rawValue
        
        AF.upload(multipartFormData: { multiPartFormData in
            for formData in bodyKeyValue {
                //data가 null인지 확인
                if(formData.dBlobData.isEmpty) {
                    multiPartFormData.append(Data(formData.sValue.utf8), withName: formData.sKey)
                } else {
                    //👀 withName - key값 👀 fi2leName - 서버에 업로드할 파일 이름 👀 mimeType - 파일 형식
                    multiPartFormData.append(formData.dBlobData, withName: formData.sKey, fileName: "junha", mimeType: "image/jpeg")
                    
                }
            }
        }, to: sURL, method: .post, headers: header)
            .uploadProgress{ progress in
                //진행상황 표시
                print(CGFloat(progress.fractionCompleted)*100) //0.12 = 12%
            }
            .response{ response in
                if(response.error == nil) {
                    var responseString: String!
                    
                    responseString = ""
                    print("response.error == nil")
                    if(response.data != nil) {
                        responseString = String(bytes: response.data!, encoding: .utf8)!
                        print("response.data != nil")
                    } else {
                        responseString = response.response!.description
                        print("response.data == nil")
                    }
                    //                print(responseString)
                    print(response.response?.statusCode)
                    
                    var responseData: NSData!
                    responseData = response.data! as NSData
                    //data크기가 길이와 같다고 생각하고,
                    var iDataLength = responseData.length
                    print("Size: \(iDataLength) Bytes")
                    print("Response Time: \(response.metrics?.taskInterval.duration ?? 0)")
                    
                }
            }
    }
    
    func returnMimeType(fileExtension: String) -> String {
        if let oUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue() {
            if let mimeType = UTTypeCreatePreferredIdentifierForTag(oUTI, kUTTagClassMIMEType, nil)?.takeRetainedValue() {
                return mimeType as String
            }
        }
        return ""
    }
}
// MARK: @objc
extension ViewController {
    @objc func getButtonTap(_ sender: UIButton) {
        var sURL: String!
        sURL = "https://httpbin.org/get"
        
        var parmas = ["name": "john", "age": "35", "dept": "HR"]
        var sParams = ""
        
        for (key, value) in parmas {
            //https://httpbin.org/get ? parameter1Key = parameter1Value & parameter2Key = parameter2Value
            sParams += key + "=" + value + "&"
            print("\(key), \(value)")
        }
        //비어있을 일이 없지만, 프로그램상 필요할 경우 사용
        if !sParams.isEmpty {
            sParams = "?" + sParams
            //&로 끝나는지 확인
            if(sParams.hasSuffix("&")) {
                sParams.removeLast()
            }
            sURL = sURL + sParams
        }
        
        //(코드를 확인하여)성공 여부 검사
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
        // 요청 변수 생성
        var sampleRequest = URLRequest(url: URL(string: sURL)!)
        
        //uploadProgress로 진행상황 확인
        //request하고, 진행상황 확인하고, 응답받음?
        AF.request(sampleRequest).uploadProgress { progress in
        }.response(responseSerializer: serializer){ response in
            //응답에 오류가 있는지 확인
            if(response.error == nil)
            {
                var responseString: String!
                responseString = ""
                //sURL의 responseBody에 있는 정보를 확인함
                if(response.data != nil) {
                    responseString = String(bytes: response.data!, encoding: .utf8)
                } else {
                    //responseString에 데이터가 없을 경우.
                    responseString = response.response?.description
                }
                print(responseString ?? "")
                print(response.response?.statusCode)
                
                var responseData: NSData!
                responseData = response.data! as NSData
                //data크기가 길이와 같다고 생각하고,
                var iDataLength = responseData.length
                print("Size: \(iDataLength) Bytes")
                print("Response Time: \(response.metrics?.taskInterval.duration ?? 0)")
            }
        }
    }
    //    @objc func postButtonTap(_ sender: UIButton) {
    ////        var sURL = "https://httpbin.org/post"
    //        var sURL = "https://ptsv2.com/t/9gmtf-1637112073/post"
    //
    //        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
    //
    //        var  sampleRequest = URLRequest(url: URL(string: sURL)!)
    //        sampleRequest.httpMethod = HTTPMethod.post.rawValue
    //
    //        AF.request(sampleRequest).uploadProgress { progress in
    //        }.response(responseSerializer: serializer) { response in
    //            if(response.error == nil) {
    //                var responseString = ""
    //
    //                if(response.data != nil) {
    //                    responseString = String(bytes: response.data!, encoding: .utf8)!
    //                } else {
    //                    responseString = response.response!.description
    //                }
    //                print(responseString)
    //                print(response.response?.statusCode)
    //
    //                var responseData: NSData!
    //                responseData = response.data! as NSData
    //                //data크기가 길이와 같다고 생각하고,
    //                var iDataLength = responseData.length
    //                print("Size: \(iDataLength) Bytes")
    //                print("Response Time: \(response.metrics?.taskInterval.duration ?? 0)")
    //            }
    //        }
    //    }
    @objc func postButtonTap(_ sender: UIButton) {
//        let url = "http://192.168.0.28:3000/signup/post"
                let url = "https://ptsv2.com/t/qpy40-1641349574/post"

//                    let url = "https://ptsv2.com/t/409e6-1637649903/post"
//            let url = "http://192.168.0.28:3000/auth/kakao"
//        let url = "http://ec2-3-36-141-213.ap-northeast-2.compute.amazonaws.com:5000/signup"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["snsId": "아이디2", "name": "이름1", "mobile": "0109999999", "postalNumber": "14232", "defaultAddress": "주소1", "detailAddress": "주소2"] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
                print(response.response?.statusCode)
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
}

extension ViewController {
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString,
                             options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
}

extension ViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    
    func setDetails() {
        getRequestButton.setTitle("GET Request", for: .normal)
        getRequestButton.addTarget(self, action: #selector(getButtonTap(_:)), for: .touchUpInside)
        postRequestButton.setTitle("POST Request", for: .normal)
        postRequestButton.addTarget(self, action: #selector(postButtonTap(_:)), for: .touchUpInside)
        postFormDataButton.setTitle("POST FormData", for: .normal)
        postFormDataButton.addTarget(self, action: #selector(postFormDataButtonTap(_:)), for: .touchUpInside)
    }
    
    func setLayout() {
        view.addSubview(getRequestButton)
        view.addSubview(postRequestButton)
        view.addSubview(postFormDataButton)
        getRequestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        postRequestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(getRequestButton.snp.bottom).offset(40)
        }
        postFormDataButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(postRequestButton.snp.bottom).offset(40)
        }
    }
}
