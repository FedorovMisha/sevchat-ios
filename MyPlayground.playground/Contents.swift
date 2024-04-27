import UIKit
import XCPlayground
import Accelerate
import SwiftUI

extension UIImage {
    public func blur(size: Int) -> UIImage! {

        let boxSize = size - (size % 2) + 1
        let image = self.cgImage!
        let inProvider = image.dataProvider!

        let height = vImagePixelCount(image.height)
        let width = vImagePixelCount(image.width)
        let rowBytes = image.bytesPerRow

        let inBitmapData = inProvider.data
        let inData = UnsafeMutablePointer<Void>(mutating: CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: height, width: width, rowBytes: rowBytes)

        let outData = malloc(image.bytesPerRow * image.height)
        var outBuffer = vImage_Buffer(data: outData, height: height, width: width, rowBytes: rowBytes)

        let _ = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(
            data: outBuffer.data,
            width: Int(outBuffer.width),
            height: Int(outBuffer.height),
            bitsPerComponent: 8,
            bytesPerRow: outBuffer.rowBytes,
            space: colorSpace,
            bitmapInfo: image.bitmapInfo.rawValue
        )!
        let imageRef = context.makeImage()!
        let bluredImage = UIImage(cgImage: imageRef)

        free(outData)

        return bluredImage
    }
}

let img = UIImage(named: "icon - edid this.png")!

let orig = UIImageView(image: img)
let blurred = img.blur(size: 50)

let o = UIImageView(frame: CGRect(x: 0, y: 0, width: orig.frame.width, height: orig.frame.height))
o.image = img
let v = UIImageView(frame: CGRect(x: 0, y: orig.frame.height, width: orig.frame.width, height: orig.frame.height))
v.image = blurred

let all = UIView(frame: CGRect(x: 0, y: 0, width: orig.frame.width, height: orig.frame.height * 2))

all.addSubview(o)
all.addSubview(v)

XCPlaygroundPage.currentPage.liveView = all

Button {

} label: {
    Text("Hi")
}

struct SomeView: View {
    var body: some View {
        Text("")
            .task {

            }
    }
}
