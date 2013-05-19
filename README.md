THGridMenu
==========

A fluid grid menu layout system that adjusts item width with device rotation.

THGridMenu is a UIView that is initialized with number of columns per row, gutter size, margin and row height. You can call an instance method `createMenuItem` that will return a THGridMenuItem at the right origin and width for the next view. THGridMenuItem is a subclass of UIControl, which itself is a subclass of UIView, so you can put anything you'd like inside.

*Note: Currently, THMenuGrid is meant to be contained inside of a navigation controller. You might have to modify to use in a standalone view or a tab controller.*

##Screenshots

Here are screenshots of a two column grid at its most basic in landscape and portrait mode.

![THGridMenu Screenshot One](http://loneyeti.com/github-images/THGridMenu1.png)
![THGridMenu Screenshot One](http://loneyeti.com/github-images/THGridMenu2.png)

##Usage

Import THGridMenu.h and THGridMenuItem.h into your view controller.

```objective-c
#import THGridMenu.h
#import THGridMenuItem.h
```

Create a THGridMenu property

```objective-c
@property (nonatomic, strong) THGridMenu *menuView;
```

Create a method to create or recreate your grid with whatever settings you'd like.

```objective-c
-(void)menuSetOrReset {
    _menuView = nil;
    _menuView = [[THGridMenu alloc] initWithColumns:2 marginSize:30 gutterSize:30 rowHeight:100];
    self.view = _menuView;
    //See next step.
    [self populateMenu];
}
```

Create a method to populate your menu (probably by iterating through a data source)

```objective-c
-(void)populateMenu {
    //Refresh data source (in this example, just read from the plist)
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"books" ofType:@"plist"];
    NSArray *books = [NSArray arrayWithContentsOfFile:path];
    //Iterate through the data source
    for (NSString *bookTitle in books) {
        //Call createMenuItem to return a THGridMenuItem with origins and width preset.
        THGridMenuItem *menuItem = [_menuView createMenuItem];
        //Do any setup to the item view. Here we call a function defined in a category.
        [menuItem addTitle:bookTitle];
        //Add the menu item to your grid view
        [self.view addSubview:menuItem];
    }
}
```

Call your menu creation method from viewWillLoad

```objective-c
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self menuSetOrReset];
}
```

Add the following to rebuild the menu when the device rotates

```objective-c
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [_menuView orientationChange];
}
```

Make sure your view controller knows that it can rotate

```objective-c
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
```

##Customizing Menu Items

THGridMenuItem is just a UIControl of known height and of unknown width. The cleanest way to customize is to create a category. For example, in our demo there is a category called BookItem that adds one method: `addTitle`:

**THGridMenuItem+BookItem.h**

```objective-c
#import "THGridMenuItem.h"

@interface THGridMenuItem (BookItem)

-(void)addTitle:(NSString *)title;

@end
```

**THGridMenuItem+BookItem.m**

```objective-c
-(void)addTitle:(NSString *)title {
    self.backgroundColor = [UIColor whiteColor];
    CGRect parentFrame = self.frame;
    CGFloat margin = 10.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.contentMode = UIViewContentModeScaleAspectFit;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:titleLabel];
}
```

Now, instead of importing THGridMenuItem.h, we can import THGridMenuItem+BookItem.h and have access to `addTitle`

Remember, though. The width is going to expand and contract depending on rotation, so keep that in mind. Height will always be what you chose when you initialized THMenuGrid.

## Todo

I created this for a new project I'm working on. Unfortunately I probably won't have time to work on this too much besides what I need for my own project. Feel free to grab this and expand on it, though. Here are some things that probably should be fixed/added:

- Should be fixed to work outside of a navigation controller
- Landscape and Portrait mode could have different column numbers and rotation would figure out how to handle that.
