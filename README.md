# M80TableViewComponent

A component-based library for UITableView  [中文版本](./Documents/README.md)

|         | Main Features  |
----------|-----------------
🙅 | No more indexpath and array out of range
👋 | Segregation of duties
😁 | UITableViewCell will be automatically reusable
🏡 | Data-driven
✅ | Safe model to view mapping
➡️ | One way binding
📥 | Easy to compose different components together
🚀 | Simple support for height cache and precalculate
🔑 | ListDiff supported


# System Requirements

* iOS 9.0 or higher
* Xcode 11.0 or higher

# Installation

### Cocoapods

```ruby
pod 'M80TableViewComponent'
```


# QuickStart

### Define custom component

```objc
@implementation M80ItemComponent

- (Class)cellClass
{
    return UITableViewCell.class;
}

- (CGFloat)height
{
    return 44.0;
}

- (void)configure:(UITableViewCell *)cell
{
    cell.textLabel.text = self.title;
}

@end

```

### Compose them

```objc

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *components = @[[M80ItemComponent component:@"Text" vcName:@"M80TextViewController"],
                            [M80ItemComponent component:@"ListDiff" vcName:@"M80ListDiffViewController"],
                            [M80ItemComponent component:@"Feed" vcName:@"M80FeedViewController"]];
    
    M80TableViewSectionComponent *section = [M80TableViewSectionComponent new];
    section.components = components;
    
    M80TableViewComponent *tableViewComponent = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    tableViewComponent.sections = @[section];
    tableViewComponent.context = context;
    
    self.tableViewComponent = tableViewComponent;
}

```



# Key Classes
|   Class      | Usage |
----------|-----------------
M80TableViewComponent | TableView component which holds many section components
M80TableViewSectionComponent | Section component which holds many cell components
M80TableViewCellComponent | Cell component which is used for managing UITableViewCell  
M80TableViewViewComponent | View componnet
M80TableViewComponentContext | Class which holds the context information for the tableview component



