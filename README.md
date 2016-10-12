# CocoaPlusKit

CocoaPlusKit 集成了Foundation、UIKit、CoreGraphics等框架下常用的类别方法。

# 安装

### CocoaPods

1. 在`Podfile`中添加`pod "CocoaPlusKit"`
2. 执行命令`pod install`或`pod update`
3. 在需要的时候导入`import <CocoaPlusKit/CocoaPlusKit.h>`

### 手动

1. 下载或克隆库的所有内容到本地
2. 编译`Framework/CocoaPlusKit.xcodeproj`
3. 将生成的`CocoaPlusKit.framework`拖拽到你的项目中
4. 选择Target下的`Build Setting`选项，设置`Allow Non-modular Includes in Framework Modules`为YES
5. 同时在`Other Linker Flags`中添加`- ObjC`和`-all_load`两个参数

# 使用

详见API文档，如有必要使用 [appledoc](https://github.com/tomaz/appledoc) 本地生成。

# 要求

* 支持iOS 6.0 以上系统

# 许可

详情见 LICENSE 文件。
