# M80TableViewComponent

UITableView 的组件化解决方案

|         | 主要特性  |
----------|-----------------
🙅 | 不用再和 IndexPath 及数组越界打交道
👋 | 权责分离，和冗长的 UITableView Adapter 说再见
😁 | UITableViewCell 自动重用
🏡 | 数据驱动的构建方式
✅ | 安全的模型视图映射关系
➡️ | 单向绑定
📥 | 灵活组装
🚀 | 自动高度缓存和简单的高度预计算支持
🔑 | 支持 ListDiff


# 系统要求

* iOS 9.0 及以上
* Xcode 11.0

# 集成

### Cocoapods

```ruby
pod 'M80TableViewComponent'
```


# 快速使用

### 定义 cell component

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

### 组装使用

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



# 主要类预览
|   类      | 概述 |
----------|-----------------
M80TableViewComponent | TableView 组件，可持有 0 至 n 个 M80TableViewSectionComponent
M80TableViewSectionComponent | Section 组件，对应 UITableView Section，可持有 0 至 n 个 M80TableViewCellComponent 
M80TableViewCellComponent | Cell 组件，与 UITableViewCell 一一对应
M80TableViewViewComponent | View 组件，对应每个 Section 的 UITableViewFooter 和 UITableViewHeader
M80TableViewComponentContext | TableView 组件上下文信息



