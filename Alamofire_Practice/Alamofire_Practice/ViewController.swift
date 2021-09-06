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
    }
    
    let getRequestButton = UIButton(type: .system)
    let postRequestButton = UIButton(type: .system)
    let postFormDataButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
    @objc func postButtonTap(_ sender: UIButton) {
//        var sURL = "https://httpbin.org/post"
        var sURL = "https://ptsv2.com/t/6trzb-1630820390/post"
        
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
        
        var  sampleRequest = URLRequest(url: URL(string: sURL)!)
        sampleRequest.httpMethod = HTTPMethod.post.rawValue
        
        AF.request(sampleRequest).uploadProgress { progress in
        }.response(responseSerializer: serializer) { response in
            if(response.error == nil) {
                var responseString = ""
                
                if(response.data != nil) {
                    responseString = String(bytes: response.data!, encoding: .utf8)!
                } else {
                    responseString = response.response!.description
                }
                print(responseString)
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
    @objc func postFormDataButtonTap(_ sender: UIButton) {
        
        var bodyKeyValue = [RequestBodyFormDataKeyValue]()
        
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "a", sValue: "b", dBlobData: Data()))
        
        //[0] Name; [1] extension
        var photoArray = [[]]
        let oArrArray = "iPhone2.jpg".components(separatedBy: ".")
        let mimeType = self.returnMimeType(fileExtension: oArrArray[1])
        let oImage = UIImage(named: "iPhone2.jpg")
        let dData = oImage?.pngData()
//        let dData = oImage?.jpegData(compressionQuality: 1)
        
        bodyKeyValue.append(RequestBodyFormDataKeyValue(sKey: "filename", sValue: "iphone", dBlobData: dData!))
        
        
//        var sURL = "https://httpbin.org/post"
//        var sURL = "https://ptsv2.com/t/6trzb-1630820390/post"
        var sURL = "http://192.168.0.28:8000/aws/test"
        
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
        
        var  sampleRequest = URLRequest(url: URL(string: sURL)!)
        sampleRequest.httpMethod = HTTPMethod.post.rawValue
        
        AF.upload(multipartFormData: {multiPartFormData in
            for formData in bodyKeyValue {
                //data가 null인지 확인
                if(formData.dBlobData.isEmpty) {
                multiPartFormData.append(Data(formData.sValue.utf8), withName: formData.sKey)
                } else {
                    multiPartFormData.append(formData.dBlobData, withName: formData.sKey, fileName: "junha", mimeType: mimeType)
                }
            }
        }, to: sURL, method: .post)
        .uploadProgress{ progress in
            //진행상황 표시
            print(CGFloat(progress.fractionCompleted)*100) //0.12 = 12%
        }
        .response{ response in
            if(response.error == nil) {
                var responseString: String!
                
                responseString = ""
                
                if(response.data != nil) {
                    responseString = String(bytes: response.data!, encoding: .utf8)!
                } else {
                    responseString = response.response!.description
                }
//                print(responseString)
                print(response.response?.statusCode)
                
                var responseData: NSData!
                responseData = response.data! as NSData
                //data크기가 길이와 같다고 생각하고,
                var iDataLength = responseData.length
                print("Size: \(iDataLength) Bytes")
                print("Response Time: \(response.metrics?.taskInterval.duration ?? 0)")            }
        }
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
