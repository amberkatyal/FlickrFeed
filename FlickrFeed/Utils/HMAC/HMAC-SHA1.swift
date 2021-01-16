//
//  HMAC-SHA1.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 16/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import Foundation

open class HMAC {

    let key: [UInt8] = []

    class internal func sha1(key: Data, message: Data) -> Data? {
        let blockSize = 64
        var key = Array<UInt8>(key)
        let message = Array<UInt8>(message)

        if key.count > blockSize {
            key = SHA1(key).calculate()
        } else if key.count < blockSize { // padding
            key += [UInt8](repeating: 0, count: blockSize - key.count)
        }

        var ipad = [UInt8](repeating: 0x36, count: blockSize)
        for idx in key.indices {
            ipad[idx] = key[idx] ^ ipad[idx]
        }

        var opad = [UInt8](repeating: 0x5c, count: blockSize)
        for idx in key.indices {
            opad[idx] = key[idx] ^ opad[idx]
        }

        let ipadAndMessageHash = SHA1(ipad + message).calculate()
        let mac = SHA1(opad + ipadAndMessageHash).calculate()
        var hashedData: Data?
        mac.withUnsafeBufferPointer { pointer in
            guard let baseAddress = pointer.baseAddress else { return }
            hashedData = Data(bytes: baseAddress, count: mac.count)
        }
        return hashedData
    }

}
