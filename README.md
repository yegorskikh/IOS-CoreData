# CoreData

<p align='center'>
This repository was written based on this book.
<p align='center'>
</p>
<p align='center'>
<a href='https://www.raywenderlich.com/books/core-data-by-tutorials' target="_blank">
<img src="https://img.shields.io/badge/Core Data-9cf"/>
<p align='center'>
</p>

## Table of Contents

- [**Your First Core Data App**](https://github.com/egorskikh/IOS-CoreData#your-first-core-data-app) 
- [**NSManagedObject Subclasses**](https://github.com/egorskikh/IOS-CoreData#nsmanagedobject-subclasses) 
- [**The Core Data Stack**](https://github.com/egorskikh/IOS-CoreData#the-core-data-stack) 
- [**Intermediate Fetching**](https://github.com/egorskikh/IOS-CoreData#intermediate-fetching) 
- [NSFetchedResultsController](https://github.com/egorskikh/IOS-CoreData#nsfetchedresultscontroller)
- Versioning & Migration
- [**Unit Testing**](https://github.com/egorskikh/IOS-CoreData#unit-testing) 
- Measuring & Boosting Performance
- Multiple Managed Object Contexts
- NSPersistentCloudKitContainer

<br> </br>

## Your First Core Data App
### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%201.%20Your%20First%20Core%20Data%20App/HitList)
- Core Data обеспечивает постоянство на диске, что означает, что ваши данные будут доступны даже после завершения работы вашего приложения или выключения вашего устройства. Это отличается от постоянства в памяти, при котором ваши данные будут сохраняться только до тех пор, пока ваше приложение находится в памяти, либо на переднем плане, либо в фоновом режиме.
- Xcode поставляется с мощным редактором модели данных, который можно использовать для создания управляемой объектной модели.
Модель управляемого объекта состоит из сущностей, атрибутов и отношений.
- **Entity** - это определение класса в **Core Data**.
- **Attribute** - это часть информации, прикрепленная к объекту.
- **Relationship** - это связь между несколькими объектами.
- **NSManagedObject** - это представление сущности Core Data во время выполнения. Вы можете читать и записывать в его атрибуты, используя Key-Value Coding(кодирование значения ключа).
- Вам нужен **NSManagedObjectContext** для **save()** или **fetch(_ :)** данных в **Core Data** и из них.


<br> </br>

## NSManagedObject Subclasses
### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%202.%20NSManagedObject%20subclasses%20/BowTies)
- **Core Data** поддерживает различные типы данных атрибутов, которые определяют, какие данные вы можете хранить в своих объектах, и сколько места они будут занимать на диске. Некоторые общие типы данных атрибутов: **String**, **Date** и **Double**.
- Тип данных атрибута **Binary Data** дает вам возможность хранить произвольные объемы двоичных данных в вашей модели данных.
- Тип данных атрибута **Transformable** позволяет хранить любой объект, соответствующий **NSSecureCoding**, в вашей модели данных.
- Использование подкласса **NSManagedObject** - лучший способ работы с сущностью Core Data. Вы можете либо сгенерировать подкласс вручную, либо позволить Xcode сделать это автоматически.
- Вы можете уточнить набор сущностей, извлеченных **NSFetchRequest**, используя **NSPredicate**.
- Вы можете установить правила проверки (например, максимальное значение и минимальное значение) для большинства типов данных атрибутов непосредственно в редакторе модели данных. Контекст управляемого объекта вызовет ошибку, если вы попытаетесь сохранить недопустимые данные.


<br> </br>

## The Core Data Stack

<p align='egorskikhcenter'>
  
![Снимок экрана 2021-07-26 в 13 59 07](https://user-images.githubusercontent.com/60622982/126978697-9a2b1570-db79-41a7-9fc9-bd040f73041f.png)
  
<p align='center'>
</p>


### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%203%20Core%20Data%20Stack/DogWalk)
- **Core Data Stack**. Стек основных данных состоит из пяти классов: 
1. *NSManagedObjectModel*
2. *NSPersistentStore*
3. *NSPersistentStoreCoordinator* 
4. *NSManagedObjectContext* 
5. ***NSPersistentContainer*** - объединяет все вместе.
- **Managed object model**. Модель управляемых объектов представляет каждый тип объекта в модели данных вашего приложения, свойства, которые они могут иметь, и отношения между ними.
- **Persistent store**. Постоянное хранилище может поддерживаться базой данных SQLite (по умолчанию), XML, двоичным файлом или хранилищем в памяти. Вы также можете предоставить собственное хранилище резервных копий с помощью API инкрементного хранилища.
- **Persistent store coordinator**. Координатор постоянного хранилища скрывает детали реализации того, как настроены ваши постоянные хранилища, и представляет простой интерфейс для контекста управляемого объекта.
- **Managed object context**. Контекст управляемого объекта управляет жизненными циклами управляемых объектов, которые он создает или извлекает. Они несут ответственность за выборку, редактирование


<br> </br>

## Intermediate Fetching
Рассмотрим пять различных способов настроить запрос на получение, чтобы вас не застали врасплох:
```swift
// 1
let fetchRequest1 = NSFetchRequest<Venue>()
let entity = 
  NSEntityDescription.entity(forEntityName: "Venue",
                             in: managedContext)!
fetchRequest1.entity = entity

// 2
let fetchRequest2 = NSFetchRequest<Venue>(entityName: "Venue")

// 3
let fetchRequest3: NSFetchRequest<Venue> = Venue.fetchRequest()

// 4
let fetchRequest4 = managedObjectModel.fetchRequestTemplate(forName: "venueFR")

// 5
let fetchRequest5 =
  managedObjectModel.fetchRequestFromTemplate(
    withName: "venueFR",
    substitutionVariables: ["NAME" : "Vivi Bubble Tea"])
```
> 1

Вы инициализируете экземпляр **NSFetchRequest** как универсальный тип: **NSFetchRequest <Venue>**. Как минимум, вы должны указать **NSEntityDescription** для запроса на выборку. В данном случае это объект Venue. Вы инициализируете экземпляр **NSEntityDescription** и используете его для установки свойства объекта запроса на выборку.

> 2

  Здесь вы используете удобный инициализатор **NSFetchRequest**. Он инициализирует новый запрос на выборку и устанавливает свойство объекта за один шаг. Вам просто нужно предоставить строку для имени объекта, а не полноценное **NSEntityDescription**.

> 3

  Так же, как второй пример был сокращением первого, третий - сокращением второго. Когда вы генерируете подкласс **NSManagedObject**, этот шаг также генерирует метод класса, который возвращает **NSFetchRequest**, уже настроенный для выборки соответствующих типов сущностей.
Отсюда и происходит **Venue.fetchRequest()**. 
Этот код находится в **Venue+CoreDataProperties.swift**.

> 4

  В четвертом примере вы получаете запрос на выборку из модели **NSManagedObjectModel**. Вы можете настроить и сохранить часто используемые запросы на выборку в редакторе модели данных Xcode. 

> 5

  Последний случай аналогичен четвертому. Получите запрос на выборку из вашей управляемой объектной модели, но на этот раз вы передадите некоторые дополнительные переменные. Эти переменные «подстановки» используются в предикате для уточнения полученных результатов.

<br> </br>

|  NSFetchRequest | | 
| ------------- | ------------- | 
| .managedObjectResultType | возвращает управляемые объекты **(значение по умолчанию)**. | 
| .countResultType | возвращает количество объектов, соответствующих запросу на выборку. | 
| .dictionaryResultType | это универсальный возвращаемый тип для возврата результатов различных вычислений. | 
| .managedObjectIDResultType | возвращает уникальные идентификаторы вместо полноценных управляемых объектов. | 

> Example
```swift
 let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Data")
 fetchRequest.resultType = .dictionaryResultType
```
### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%204.%20Intermediate%20Fetching/BubbleTeaFinder)
- **NSFetchRequest** - это общий тип. Он принимает параметр типа, который указывает тип объектов, которые вы ожидаете получить в результате запроса на выборку.
- Если вы планируете повторно использовать один и тот же тип выборки в разных частях приложения, рассмотрите возможность использования редактора модели данных для хранения неизменяемого запроса выборки непосредственно в вашей модели данных.
- Используйте тип результата счетчика **NSFetchRequest**, чтобы эффективно вычислять и возвращать счетчики из SQLite.
- Используйте тип результата словаря **NSFetchRequest**, чтобы эффективно вычислять и возвращать средние, суммы и другие общие вычисления из **SQLite**.
- Запрос на выборку использует различные методы, такие как использование размеров пакетов, ограничений пакетов и ошибок, чтобы ограничить объем возвращаемой информации.
- Добавьте описание сортировки в запрос на выборку, чтобы эффективно отсортировать полученные результаты.
- Получение большого количества информации может заблокировать основной поток. Используйте **NSAsynchronousFetchRequest**, чтобы передать часть этой работы фоновому потоку.
- **NSBatchUpdateRequest** и **NSBatchDeleteRequest** сокращают количество времени и памяти, необходимые для обновления или удаления большого количества записей в **Core Data**.


<br> </br>

## NSFetchedResultsController
### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%205.%20NSFetchedResultsController/WorldCup/WorldCup)
- **NSFetchedResultsController** абстрагирует большую часть кода, необходимого для синхронизации табличного представления с базовым хранилищем данных.
- По своей сути **NSFetchedResultsController** является оболочкой вокруг **NSFetchRequest** и контейнером для полученных результатов.
- Контроллер полученных результатов требует установки по крайней мере **одного дескриптора сортировки** в своем запросе на выборку. Если вы забудете дескриптор сортировки, ваше приложение выйдет из строя.
- Вы можете настроить контроллер **sectionNameKeyPath** для полученного результата, чтобы указать атрибут для группировки результатов в разделы табличного представления. Каждое уникальное значение соответствует отдельному разделу представления таблицы.
- Группировка набора полученных результатов по разделам - дорогостоящая операция. Избегайте многократного вычисления разделов, указав **имя кеша** в выбранном контроллере результатов.
- Контроллер выбранных результатов может отслеживать изменения в своем наборе результатов и уведомлять своего делегата **NSFetchedResultsControllerDelegate**, чтобы тот ответил на эти изменения.
- **NSFetchedResultsControllerDelegate** отслеживает изменения в отдельных записях Core Data (были ли они вставлены, удалены или изменены), а также изменения целых разделов.
- Дифференцируемые источники данных упрощают работу с контроллерами выбранных результатов и табличными представлениями.

<br> </br>

## Versioning & Migration
### Key points

<br> </br>

## Unit Testing
### Key points
- [example](https://github.com/egorskikh/IOS-CoreData/tree/main/Chapter%207.%20Unit%20Testing)
- **Unit tests** должны следовать принципам **FIRST**: быстро, изолированно, повторяемо, самопроверяемся и своевременно.
- Создайте *persistent store*(постоянное хранилище), специально предназначенное для модульного тестирования, и сбрасывайте его содержимое с каждым тестом. Использование хранилища **SQLite** в памяти - самый простой подход.
- **Core Data** может использоваться асинхронно и легко тестируются с помощью класса **XCTestExpectation**.


<br> </br>

## Measuring & Boosting Performance
### Key points

<br> </br>

## Multiple Managed Object Contexts
### Key points

<br> </br>

## NSPersistentCloudKitContainer
### Key points










