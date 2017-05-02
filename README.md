# QXTableView
## A UITableView wrap for convenice use.

### basic rules
1、View -> Item -> Data  
Each view has an item model, And each item has a data for bussiness.  
etc:  
> QXTableView -> QXTableVieItem ( has no data )   
> QXTableViewCell -> QXTableViewCellItem -> data  
> QXTableViewHeaderView -> QXTableViewHeaderItem -> data  
> QXTableViewFooterView -> QXTableViewFooterItem -> data  

2、update  
> Setting Item to View cause an update to View  
> Setting Data to item cause an update to Item & View  


### use

There are four kinds of table view for use:  
> 【QXMutiHeightTableView】    
Normal, use height in item  
> 【QXEstimatedHeightTableView】    
EstimatedHeight, use estimatedHeight in item  
> 【QXStaticEstimatedHeightTableView】 
FixEstimatedHeight, ignore estimatedHeight and height in item  
> 【QXStaticHeightTableView】 
FixHeight, ignore estimatedHeight and height in item    

Create table view 
```swift     
    lazy var tableView: QXStaticEstimatedHeightTableView<String, String, Any> = {
        let one = QXStaticEstimatedHeightTableView<String, String, Any>(style: .plain)
        return one
    }()

```

Create table view item 
```swift     

    var items = [QXTableViewCellItem<Any>]()
        for person in persons {
        let item = QXTableViewCellItem<Any>(data: person, cellClass: PersonCell.self)
        items.append(item)
    }

    let headerText = "Header: 0"
    let header = QXTableViewHeaderItem<String>(data: headerText, viewClass: HeaderView.self)

    let footerText = "Footer: 0" + RadomiseText(100)
    let footer = QXTableViewFooterItem<String>(data: footerText, viewClass: FooterView.self)

    let sectionItem = QXTableViewSectionItem<String, String, Any>(header: header, footer: footer, items: items)

    let tableViewItem = QXTableViewItem<String, String, Any>(sectionItems: [sectionItem])    

```

Update 
```swift   
    // update table view
    tableView.item = tableViewItem
    // update cell
    cellItem.data = newPerson
    
```

Model & Cell 
```swift   
    class PersonCell: QXTableViewCell<Person> {
        override func update(item: QXTableViewCellItem<Person>) {
            super.update(item: item)
            let person = item.data
            // to update the cell
        }
    }
    
```
Or
```swift  
    class PersonCell: QXTableViewCell<Any> {
        override func update(item: QXTableViewCellItem<Any>) {
            super.update(item: item)
                if let person = item.data as? Person {
                // to update the cell
            }
        }
    }

```
Tips:  
To contain muti type cells, a QXTableViewCellItem must has the Any type of data (QXTableViewCellItem\<Any\>), So is the QXTableViewCell


Enjoy!






