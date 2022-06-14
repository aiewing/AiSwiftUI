

/*
 C 系语言中在方法内部我们是可以任意添加成对的大括号 {} 来限定代码的作用范围的。这么做一般来说有两个好处，首先是超过作用域后里面的临时变量就将失效，这不仅可以使方法内的命名更加容易，也使得那些不被需要的引用的回收提前进行了，可以稍微提高一些代码的效率；另外，在合适的位置插入括号也利于方法的梳理，对于那些不太方便提取为一个单独方法，但是又应该和当前方法内的其他部分进行一些区分的代码，使用大括号可以将这样的结构进行一个相对自然的划分。
 
 
 -(void)loadView {
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

     {
         UILabel *titleLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(150, 30, 200, 40)];
         titleLabel.textColor = [UIColor redColor];
         titleLabel.text = @"Title";
         [view addSubview:titleLabel];
     }

     {
         UILabel *textLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(150, 80, 200, 40)];
         textLabel.textColor = [UIColor redColor];
         textLabel.text = @"Text";
         [view addSubview:textLabel];
     }

     self.view = view;
 }
 
 在 Swift 2.0 中，为了处理异常，Apple 加入了 do 这个关键字来作为捕获异常的作用域。这一功能恰好为我们提供了一个完美的局部作用域，现在我们可以简单地使用 do 来分隔代码了
 */

do {
    print("-------")
}


/*
 在 Objective-C 中还有一个很棒的技巧是使用 GNU C 的声明扩展来在限制局部作用域的时候同时进行赋值，运用得当的话，可以使代码更加紧凑和整洁。比如上面的 titleLabel 如果我们需要保留一个引用的话，在 Objective-C 中可以写为
 
 self.titleLabel = ({
     UILabel *label = [[UILabel alloc]
             initWithFrame:CGRectMake(150, 30, 20, 40)];
     label.textColor = [UIColor redColor];
     label.text = @"Title";
     [view addSubview:label];
     label;
 });
 */

/*
 Swift 里当然没有 GNU C 的扩展，但是使用匿名的闭包的话，写出类似的代码也不是难事
 */

import UIKit
import Foundation

let titleLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 150, y: 30, width: 200, height: 40))
    label.textColor = .red
    label.text = "Title"
    return label
}()
