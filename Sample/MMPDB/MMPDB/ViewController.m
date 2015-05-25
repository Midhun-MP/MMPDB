//
//  ViewController.m
//  MMPDB
//
//  Created by Midhun on 5/5/15.
//  Copyright (c) 2015 Midhun. All rights reserved.
//

#import "ViewController.h"
#import "MMPDBCommon.h"

@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) MMPDBResultSet *dbResult;
@property (nonatomic, weak) IBOutlet UITableView *contactList;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MMPDB *db = [[MMPDB alloc] init];
    NSString *fromPath = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"sqlite"];
    NSString *toPath   = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, -1, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Database.sqlite"];
    [db copyDB:fromPath to:toPath reWrite:NO];
    //[db initializeDBWithPath:toPath];
    [db initializeDBWithName:@"Database.sqlite"];
    [db executeQuery:@"SELECT * FROM Contacts"];
    
    _dbResult = [db resultSet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dbResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    cell.textLabel.text       = _dbResult[indexPath.row][@"Name"];
    cell.detailTextLabel.text = _dbResult[indexPath.row][@"Phone"];
    return cell;
}

@end
