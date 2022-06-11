




// 有的默认参数写的是 default，这是含有默认参数的方法所生成的 Swift 的调用接口

func NSLocalizedString(key: String,
                 tableName: String? = default,
                    bundle: NSBundle = default,
                     value: String = default,
                   comment: String) -> String

func assert(@autoclosure condition: () -> Bool,
            @autoclosure _ message: () -> String = default,
                              file: StaticString = default,
                              line: UWord = default)
