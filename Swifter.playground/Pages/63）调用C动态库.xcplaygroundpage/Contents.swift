


/*
 C 是程序世界的宝库，在我们面向的设备系统中，也内置了大量的 C 动态库帮助我们完成各种任务。比如涉及到压缩的话我们很可能会借助于 libz.dylib，而像 xml 的解析的话一般链接 libxml.dylib 就会方便一些。
 
 因为 Objective-C 是 C 的超集，因此在以前我们可以无缝地访问 C 的内容，只需要指定依赖并且导入头文件就可以了。但是骄傲的 Swift 的目的之一就是甩开 C 的历史包袱，所以现在在 Swift 中直接使用 C 代码或者 C 的库是不可能的。举个例子，计算某个字符串的 MD5 这样简单地需求，在以前我们直接使用 CommonCrypto 中的 CC_MD5 就可以了，但是现在因为我们在 Swift 中无法直接写 #import <CommonCrypto/CommonCrypto.h> 这样的代码，这些动态库暂时也没有 module 化，因此快捷的方法就只有借助于通过 Objective-C 来进行调用了。因为 Swift 是可以通过 {product-module-name}-Bridging-Header.h 来调用 Objective-C 代码的，于是 C 作为 Objective-C 的子集，自然也一并被解决了。比如对于上面提到的 MD5 的例子，我们就可以通过头文件导入以及添加 extension 来解决
 
 “// TargetName-Bridging-Header.h
 #import <CommonCrypto/CommonCrypto.h>

 // StringMD5.swift
 extension String {
      var MD5: String {
          var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
 if let data = data(using: .utf8) {
     data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> Void in
         CC_MD5(bytes, CC_LONG(data.count), &digest)
     }
 }

 var digestHex = ""
 for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
     digestHex += String(format: "%02x", digest[index])
 }

 return digestHex
}
}

// 测试
print("swifter.tips".MD5)

// 输出
// dff88de99ff03d109de22fed4f71a273”
 
 
 当然，那些有强迫症的处女座读者可能不会希望在代码中沾上哪怕一点点 C 的东西，而更愿意面对纯纯的 Swift 代码，这样的话，也不妨重新制作 Swift 版本的轮子。比如对于 CommonCrypto 里的功能，已经可以在这里
 【https://github.com/krzyzanowskim/CryptoSwift】
 找到完整的 Swift 实现了，如果你只是需要 MD5 的话，这里也有一个实现。不过如果可能的话，暂时还是建议尽量使用现有的经过无数时间考验的 C 库。一方面现在 Swift 还很年轻，各种第三方库的引入和依赖机制还并不是很成熟；另外，使用动态库毕竟至少可以减少一些 app 尺寸，不是么？
 */
