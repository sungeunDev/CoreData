# Chap 2. NSManagedObject Subclasses

## ㅁ Todo
- At the core of this chapter is subclassing NSManagedObject to make your own classes for each entity
- What you have to do now is take this sample data, store it in Core Data and use it to implement the bow tie management functionality

## ㅁ Important contents
- Getting started
- Modeling your data
- Storing non-standard data types in Core Data
- Managed object subclasses
- Propagating a managed context

### -. Modeling your data

- UUID (p51)

> it is short for universally unique identifier and it is commonly used to unique identify information.

- URI (p51)

> URI stands for uniform resource identifier and it is used to name and identify different resources like files and web pages.   
> In fact, all URLs are URIs!  

- Int 16, 32, 63 (p52)

> 16, 32 and 64 refer to the number of bits representing the integer.  
> Range for 16-bit integer: -32768 to 32767   
> Range for 32-bit integer: –2147483648 to 2147483647   
> Range for 64-bit integer: –9223372036854775808 to 9223372036854775807   

- Allows External Storage (p52-3)

-. binary data로 저장할 수 있지만, string인 name에 접근할 때도 이 데이터를 불러와서 앱 성능에 영향을 끼칠 수 있음.  
> Core Data provides the option of storing arbitrary blobs of binary data directly in your data model. These could be anything from images, to PDF files, to anything that can be serialized into zeroes and ones.

>As you can imagine, this convenience can come at a steep cost. Storing a large amount of binary data in the same SQLite database as your other attributes will likely impact your app’s performance. That means a giant binary blob would be loaded into memory each time you access an entity, even if you only need to access its name!

-. 외부 저장소 허용 기능을 통해 이런 부작용을 막을 수 있음.   
> When you enable Allows External Storage, Core Data heuristically decides on a per-value basis if it should save the data directly in the database or store a URI that points to a separate file.
> 
> 외부 저장소 허용 (Allows External Storage)을 활성화하면 핵심 데이터는 데이터를 데이터베이스에 직접 저장하거나 별도의 파일을 가리키는 URI를 저장해야하는 경우 값 당 기준에 따라 경험적으로 결정합니다.
> 
Note: The Allows External Storage option is only available for the binary data attribute type. In addition, if you turn it on, you won’t be able to query Core Data using this attribute.


### -. Storing non-standard data types in Core Data (p53)
> You can save any data type to Core Data (even ones you define) using the Transformable type as long as your type conforms to the NSCoding protocol.

> 유형이 NSCoding 프로토콜을 준수하는 한 변형 가능 유형을 사용하여 코어 데이터 (정의한 것조차도)에 모든 데이터 유형을 저장할 수 있습니다.

-. NSCoding protocol
> Note: The NSCoding protocol (not to be confused with Swift’s Codable protocol) is a simple way to archive and unarchive objects that descend from NSObject into data buffers so they can be saved to disk.  
[-. about NSCoding protocol link](http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data)


### -. Managed object subclasses
-. NSManagedObject에 key-value를 이용하여 접근할 수 있지만, key값, 즉 문자열을 이용하는 것은 mistyping, misspelling의 위험성이 큼. 이를 대체하는 가장 좋은 방법은 `create NSManagedObject subclasses for each entity in your data model.` NSMangedObject를 서브클래싱 하는 것.   
-. Entity의 `Data Model inspector - Codegen`에서 서브클래싱을 수동/자동으로 선택할 수 있음(XCode 8 이후부터)   

> Note: Make sure you change this code generation setting before your first compilation after you add the Bowtie entity to the model.
If you set the code generation setting after your first compilation, you’ll have two versions of the managed object subclass: one in derived data and a second one in your source code. If this happens, you’ll run into problems when you try to compile again.

> 참고 : Bowtie 엔터티를 모델에 추가 한 후 처음 컴파일하기 전에이 코드 생성 설정을 변경해야합니다.  
처음 컴파일 한 후 코드 생성 설정을 지정하면 파생 된 데이터와 소스 코드의 두 가지 버전 인 관리 대상 하위 클래스가 생성됩니다. 이런 일이 발생하면 다시 컴파일하려고 할 때 문제가 발생합니다.  

-. `Editor\Create NSManagedObject Subclass…` 하면 2개 파일 생성
> Bowtie+CoreDataProperties.swift.   
> Open Bowtie+CoreDataClass.swift.  


### -. Propagating a managed context



---------------

## ㅁ BowTies Proj
- truncating
> Creates an integer from the given value, rounding toward zero when necessary.
> 필요한 경우 0을 반올림하여 지정된 값에서 정수를 만듭니다.

```swift
private extension UIColor {
  static func color(dict: [String : Any]) -> UIColor? {
    
    guard let red = dict["red"] as? NSNumber,
      let green = dict["green"] as? NSNumber,
      let blue = dict["blue"] as? NSNumber else {
        return nil
    }
    
    return UIColor(red: CGFloat(truncating: red) / 255.0,
                   green: CGFloat(truncating: green) / 255.0,
                   blue: CGFloat(truncating: blue) / 255.0,
                   alpha: 1)
  }
}
```