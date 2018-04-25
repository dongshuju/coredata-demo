
### CoreData

<br> 介绍

在Cocoa环境下，如果你想使用数据库（如sqlite），你可以使用sql语句的方式通过相关的工具类进行数据库的直接操作。当然你也可以通过别人封装之后的一些简单框架，使得你的操作更加简单（如FMDB BNRPersistence）。

Cocoa框架本身提供了CoreData这个API可方便的让开发者通过操作对象的方式在操作数据库。CoreData是一个对象图(object graph)以及持久化的管理框架。我们可以通过CoreData创对象，设置好象之间的关系，然后将其持久化（我们甚至可以使用内存数据库），或者从硬盘上将持久化后的数据加载到内存中。对象图，我们可以创建一个个的对象，并维持不同对象之间的关系，一对一，一对多等。

CoreData有大量的特性，诸如支持Redo，Undo的功能，这些很多Document based的程序中显得非常的有用。提供数据model结构变化轻量级的迁移方案。CoreData还通过Binding特性和控件的紧密结合，这样使得只需要少量的代码便可以完成强大的功能。

Core Data是个框架，它使得开发者可以把数据当成对象来操作，而不必在乎数据在磁盘中的存储方式。对于Objective-C程序员来说，这很有用，因为他们已经可以通过代码非常熟练地操作对象了。由Core Data所提供的数据对象叫做托管对象（managed object），而Core Data本身则位于你的应用程序和持久化存储区（persistent store）之间。持久化存储区是个通用的术语，指的是像SQLite数据库、XML文件（iOS不支持用XML文件作为持久化存储区）或Binary store（又名atomic store）这种数据文件。由于这些文件在底层硬件重启之后还会保留下来，所以它们是持久的。还有一种持久化存储方式，它的名字非常奇怪，叫做“In-Memory store”。虽说In-Memory store并不是“持久的”，但开发者在用它管理数据时却可以享受Core Data的所有优点，诸如变更管理与数据验证等，另外，其效率自然也是相当高的。


为了把数据从托管对象映射到持久化存储区中，Core Data需要使用托管对象模型，而开发者则可以通过对象图（object graph）来配置应用程序的数据结构。可以把对象图想象成一系列“饼干模型切割刀”（cookie cutter），而托管对象正是用这些切割刀切出来的。对象图里的对象指的是实体，每个实体就好比一把“饼干模型切割刀”，用于制作自定义的托管对象。有了托管对象之后，就可以直接在Objective-C里面操作它们，而无需再编写SQL代码了（笔者假定你使用SQLite作为持久化存储区，因为这是最常用的一种持久化存储方式）。当把数据保存到磁盘的时候，Core Data显然会把这些托管对象映射回持久化存储区里面。


托管对象持有一份对持久化存储区里相关数据的拷贝。如果用数据库作为持久化存储区，那么托管对象可能对应于数据库里某张数据表中的一行。如果用XML文件作为持久化存储区（此方式只有Mac系统支持），那么托管对象可能对应于某个数据元素（data element）里面的一份数据。托管对象可以是NSManagedObject类的实例，但一般情况下，它都是某个NSManagedObject子类的实例。

所有托管对象都必须位于托管对象上下文（managed object context）里面，而托管对象上下文又位于高速的易失性存储器里面，也就是位于RAM中。为什么需要有托管对象上下文呢？原因之一就是在磁盘与RAM之间传输数据时会有开销。磁盘读写速度比RAM慢得多，所以不应该频繁访问它。而有了托管对象上下文之后，对于原来需要读取磁盘才能获取到的数据，现在只需访问这个上下文，就可以非常迅速地获取到了。但它的缺点在于，开发者必须在托管对象上下文上面定期调用save:方法，以将变更后的数据写回磁盘。托管对象上下文的另一个功能是记录开发者对托管对象所做的修改，以提供完整的撤销与重做支持。

