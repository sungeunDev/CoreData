# Chap 1. NSManagedObject Subclasses

## ㅁ 챕터 1에서 배울 내용
- Model data using Xcode’s model editor
- Add new records to Core Data
- Fetch a set of records from Core Data
- Display the fetched records using a table view.


## ㅁ Important contents
- Getting started
- Modeling your data
- Saving to Core Data
- Fetching from Core Data


### -. Getting started (p16)
> The NSPersistentContainer consists of a set of objects that facilitate saving and retrieving information from Core Data. 
Inside this container is an object to manage the Core Data state as a whole, an object representing the Data Model, and so on.

> NSPersistentContainer는 핵심 데이터에서 정보를 저장하고 검색하는 것을 용이하게하는 개체 집합으로 구성됩니다.
이 컨테이너 내부에는 전체적으로 코어 데이터 상태를 관리하는 객체, 데이터 모델을 나타내는 객체 등이 있습니다.

### -. Modeling your data (p29)
> In this section, you’ll replace these strings with Core Data objects.
The first step is to create a managed object model, which describes the way Core Data represents data on disk.
By default, Core Data uses a SQLite database as the persistent store, so you can think of the Data Model as the database schema.

> 이 섹션에서는 이러한 문자열을 핵심 데이터 개체로 대체합니다.
첫 번째 단계는 핵심 데이터가 디스크의 데이터를 나타내는 방식을 설명하는 관리 대상 개체 모델을 만드는 것입니다.
기본적으로 Core Data는 SQLite 데이터베이스를 영구 저장소로 사용하므로 데이터 모델을 데이터베이스 스키마로 생각할 수 있습니다.


> Note: You’ll come across the word managed quite a bit in this book. If you see “managed” in the name of a class, such as in NSManagedObjectContext, chances are you are dealing with a Core Data class. “Managed” refers to Core Data’s management of the life cycle of Core Data objects.

> 참고 :이 책에서 다루는 단어를 많이 보게 될 것입니다. NSManagedObjectContext와 같이 클래스 이름에 "managed"가 표시되면 핵심 데이터 클래스를 처리 할 가능성이 있습니다. "관리 대상"은 Core Data가 Core Data 객체의 수명주기를 관리하는 것을 의미합니다.


### -. Saving to Core Data (p34)
> how to grab attribute from the NSManagedObject

```swift
cell.textLabel?.text =
  person.value(forKeyPath: "name") as? String’
```

> As it turns out, NSManagedObject doesn’t know about the name attribute you defined in your Data Model, so there’s no way of accessing it directly with a property. The only way Core Data provides to read the value is key-value coding, commonly referred to as KVC.’

> Note : Key-value coding is available to all classes inheriting from NSObject, including NSManagedObject. You can’t access properties using KVC on a Swift object that doesn’t descend from NSObject.
키 - 값 코딩은 NSManagedObject를 포함하여 NSObject를 상속 한 모든 클래스에서 사용할 수 있습니다. NSObject에서 유래하지 않은 Swift 개체에서 KVC를 사용하여 속성에 액세스 할 수 없습니다.


### -. Fetching from Core Data


## ㅁ Terms (p31)
- Entity
: An entity is a class definition in Core Data. 
The classic example is an Employee or a Company. 
In a relational database, an entity corresponds to a table.

- Attribute
: An attribute is a piece of information attached to a particular entity. 
For example, an Employee entity could have attributes for the employee’s name, position and salary. 
In a database, an attribute corresponds to a particular field in a table.

- Relationship
: A relationship is a link between multiple entities. 
In Core Data, relationships between two entities are called to-one relationships, while those between one and many entities are called to-many relationships. 
For example, a Manager can have a to-many relationship with a set of employees, whereas an individual Employee will usually have a to-one relationship with his manager.


- Note
: You’ve probably noticed that entities sound a lot like classes. Likewise, attributes and relationships sound a lot like properties. What’s the difference? 
You can think of a Core Data entity as a class definition and the managed object as an instance of that class.


---------------

## ㅁ HitList Proj
- viewDidload 에서 title 프로퍼티 선언 없이 이용 가능한데, embeded navi 해서인지 아님 기본으로 있는건지 궁금..  
ㄴ  Localized title for use by a parent controller.  
ㄴ 라는 설명으로 봐서는 parent controller인 navi title을 의미하는 게 맞는 듯.  
  
- unowned self  
ㄴ 공부하기 T.T  