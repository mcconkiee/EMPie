//
//  EMMainViewController.m
//  EMPieSlice
//
//  Created by Eric McConkie on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMMainViewController.h"
#import "SandboxViewController.h"
#import "OppositesViewController.h"
@interface EMMainViewController ()

@end

@implementation EMMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCellid = @"defaultCellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellid];
    if (cell==nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCellid] autorelease];
        
    }
 
    switch (indexPath.row) {
        case 0:
            [[cell textLabel]setText:@"Sandbox"];
            break;
        case 1:
            [[cell textLabel]setText:@"Opposites"];
            break;
        default:
            break;
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc= nil;
    switch (indexPath.row) {
        case 0:
            vc = [[SandboxViewController alloc]initWithNibName:@"SandboxViewController" bundle:nil];
            break;
            
        case 1:
            vc = [[OppositesViewController alloc]init];
            break;
            
        default:
            break;
    }
    if (vc) 
        [self.navigationController pushViewController:vc animated:YES];
}

@end
