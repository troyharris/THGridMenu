//
//  RootViewController.m
//  THGridMenu Demo
//
//  Created by Troy HARRIS on 5/17/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "RootViewController.h"
#import "THGridMenuItem+BookItem.h"

@interface RootViewController ()
-(void)menuSetOrReset;
-(void)populateMenu;
@end

@implementation RootViewController

#pragma mark - Methods you must add to your VC


// You need a method like this to setup your menu
-(void)menuSetOrReset {
    //Reset grid
    _menuView = nil;
    //Set your grid options here. If this is a universal app, consider different settings for iPhone/iPad
    _menuView = [[THGridMenu alloc] initWithColumns:2 marginSize:30 gutterSize:30 rowHeight:100];
    //Do any customization of the grid container
    _menuView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    //Replace the root view with the newly created grid container
    self.view = _menuView;
    //Call your method that will populate the grid
    [self populateMenu];
}

// You need a method like this that can iterate through your data source and create the menu items
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

//Call your menu reset method any time the view will appear
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self menuSetOrReset];
}

//You need this if you support interface rotation
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [_menuView orientationChange];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
