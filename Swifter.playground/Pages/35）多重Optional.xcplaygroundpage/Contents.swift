




/*
 我们使用的类型后加上 ? 的语法只不过是 Optional 类型的语法糖，而实际上这个类型是一个 enum
 */

/*
 enum Optional<T> : _Reflectable, NilLiteralConvertible {
     case None
     case Some(T)

     //...
 }
 */

var aNil: String? = nil

var anotherNil: String?? = aNil
var literalNil: String?? = nil

/*
 anotherNil 和 literalNil 是不是等效的呢？答案是否定的。anotherNil 是盒子中包了一个盒子，打开内层盒子的时候我们会发现空气；但是 literalNil 是盒子中直接是空气
 */
