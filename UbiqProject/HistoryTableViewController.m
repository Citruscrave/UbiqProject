//
//  HistoryTableViewController.m
//  UbiqProject
//
//  Created by chris ly on 12/8/15.
//  Copyright © 2015 Joey. All rights reserved.
//

#import "SWRevealViewController.h"
#import "HistoryTableViewCell.h"
#import "HistoryTableViewController.h"

@interface HistoryTableViewController () {
    NSArray *firstQueryObjects;
    NSMutableArray *secondQueryObjects;
    NSMutableDictionary *pairedObjects;
}

@end

@implementation HistoryTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"History";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Menu"
                                   style:UIBarButtonItemStyleDone
                                   target:self.revealViewController
                                   action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self fetchParseData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    static NSString *myCellIdentifier = @"HistoryCustomCell";
    UINib *nib = [UINib nibWithNibName:@"HistoryCustomCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:myCellIdentifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchParseData{
    PFQuery *getFirstUserQuery = [PFQuery queryWithClassName:@"Ballot"];
    PFQuery *getSecondUserQuery = [PFQuery queryWithClassName:@"Ballot"];
    
    NSMutableArray *ballotIDFromFirstQueryObjects = [[NSMutableArray alloc] init];
    secondQueryObjects = [[NSMutableArray alloc] init];
    
    NSMutableArray *pairedArray = [[NSMutableArray alloc] init];
    pairedObjects = [[NSMutableDictionary alloc] init];
    //filtering data
    [getFirstUserQuery whereKey:@"username" equalTo:[[PFUser currentUser] username]];
    firstQueryObjects = [getFirstUserQuery findObjects];
    
    for (PFObject *object in firstQueryObjects)
        [ballotIDFromFirstQueryObjects addObject:object[@"ballotID"]];
    

    for (int i = 0; i < [ballotIDFromFirstQueryObjects count]; i++) {
        [getSecondUserQuery whereKey:@"ballotID" equalTo:ballotIDFromFirstQueryObjects[i]];
        [secondQueryObjects  addObject:[getSecondUserQuery findObjects]];
    }

//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            NSLog(@"%@", objects);
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
//    if (cell) {
//        
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        return 1;
//        
//    } else {
//        
//        // Display a message when the table is empty
//        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//        
//        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
//        messageLabel.textColor = [UIColor blackColor];
//        messageLabel.numberOfLines = 0;
//        messageLabel.textAlignment = NSTextAlignmentCenter;
//        [messageLabel sizeToFit];
//        
//        self.tableView.backgroundView = messageLabel;
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        NSLog(@"****there is no data currently available****");
//   }
//    
//    return 0;
//    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [secondQueryObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *myCellIdentifier = @"HistoryCustomCell";
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:@"https://scontent.fhou2-1.fna.fbcdn.net/hphotos-xla1/v/t1.0-9/1524765_781472518533443_811718135_n.jpg?oh=d8a3b8539862aeeed0ad835ee3a63f29&oe=56DDE7D4"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //SCALABILITY SUCKS HERE ONLY GOOD FOR TWO PEOPLE CHANGE LATER ON FOR FUTURE IMPLEMENTATIONS
    NSArray *currentObjects = secondQueryObjects[indexPath.row];
    PFObject *username1 = currentObjects[1];
    PFObject *username2 = currentObjects[0];

    cell.firstPersonName.text = username1[@"username"];
    cell.secondPersonName.text = username2[@"username"];
    [cell.mapImage setImage:image];
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
