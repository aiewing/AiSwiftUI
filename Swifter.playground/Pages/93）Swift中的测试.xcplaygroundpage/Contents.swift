


/*
 在 Swift 2.0 中， Apple 为 app 的测试开了“后门”。现在我们可以通过在测试代码中导入 app 的 target 时，在之前追加 @testable，就可以访问到 app target 中 internal 的内容了。

 
 // 位于 app target 的业务代码
 func methodToTest() {

 }

 // 测试
 @testable import MyApp

 //...
 func testMethodToTest() {

     // 配置测试

     someObj.methodToTest()

     // 断言结果
 }
 
 */
