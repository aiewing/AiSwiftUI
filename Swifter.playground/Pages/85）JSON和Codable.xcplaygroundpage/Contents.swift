


/*
 如果 app 需要有网络功能并且有一个后端服务器处理和返回数据的话，那么现在基本上要和 JSON 打交道是没跑儿了的。在 Swift 4 之前处理 JSON 其实是一件挺棘手的事情，因为 Swift 对于类型的要求非常严格，所以在解析完 JSON 之后想要从结果的 Any 中获取某个键值是一件非常麻烦的事情。举个例子，我们使用 NSJSONSerialization 解析完一个 JSON 字符串后，得到的是 Any?
 
 Swift 4 中新加入了 Codable 协议，用来处理数据的序列化和反序列化。利用内置的 JSONEncoder 和 JSONDecoder，在对象实例和 JSON 表现之间进行转换变得非常简单。要处理上面的 JSON，我们可以创建一系列对应的类型，并声明它们实现 Codable
 
 只要一个类型中所有的成员都实现了 Codable，那么这个类型也就可以自动满足 Codable 的要求。在 Swift 标准库中，像是 String，Int，Double，Date 或者 URL 这样的类型是默认就实现了 Codable 的，因此我们可以简单地基于这些常见类型来构建更复杂的 Codable 类型。另外，如果 JSON 中的 key 和类型中的变量名不一致的话 (这很常见，因为 JSON 中往往使用下划线命名 key 值，而 Swift 中的命名规则一般是驼峰式)，我们还需要在对应类中声明 CodingKeys 枚举，并用合适的键值覆盖对应的默认值
 
 */
