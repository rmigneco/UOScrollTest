//
//  UOTabScrollViewController.m
//  scrollviewTest
//
//  Created by Ray Migneco on 10/24/14.
//  Copyright (c) 2014 Urban Outfitters. All rights reserved.
//

#import "UOTabScrollViewController.h"

static const float headerViewHt = 60.0f;
static const float segControlHt = 40.0f;

@interface UOTabScrollViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, assign) NSUInteger numContentItems;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *letterArr;
@property (nonatomic, strong) NSArray *randomArr;
@property (nonatomic, strong) NSMutableArray *tableArr;

@end

@implementation UOTabScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"test";
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.baseScrollView.delegate = self;
    self.segControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"First", @"Second", @"Third", nil]];
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.baseScrollView.showsHorizontalScrollIndicator  = self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.pagingEnabled = YES;
    
    self.dataArr = [NSArray arrayWithObjects:@"1", @"2", @"3",@"4",@"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", nil];
    self.letterArr = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", nil];
    self.randomArr = [NSArray arrayWithObjects:@"cat", @"dog", @"horse", @"sheep", @"beaver", @"goat", @"deer", @"cow", @"moose", @"caribou", @"antelope", nil];
    
    self.tableArr = [NSMutableArray array];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.baseScrollView.frame = self.view.frame;
    self.segControl.frame = CGRectMake(0.0, 64.0, CGRectGetWidth(self.view.frame), segControlHt);
    
    self.baseScrollView.backgroundColor = [UIColor blackColor];
    self.segControl.backgroundColor = [UIColor whiteColor];
    self.segControl.alpha = 0.9;
    
    self.numContentItems = 3;
    
    for (NSUInteger i = 0; i < self.numContentItems; i ++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0 + i*CGRectGetWidth(self.view.frame), 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 10.0)];
        tableView.tableHeaderView.backgroundColor = [UIColor redColor];
        tableView.tableFooterView = [UIView new];
        tableView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.segControl.frame), 0, 0, 0);
        tableView.scrollEnabled = YES;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor lightGrayColor];
        tableView.tag = i;
        
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        refreshControl.backgroundColor = [UIColor purpleColor];
        refreshControl.tintColor = [UIColor whiteColor];
        [refreshControl addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventValueChanged];
        refreshControl.tag = i;
        [tableView addSubview:refreshControl];
        
        [self.tableArr addObject:tableView];

        [self.baseScrollView addSubview:tableView];
    }
    
    [self.baseScrollView setContentSize:CGSizeMake(self.numContentItems * CGRectGetWidth(self.view.frame), 1)];
    [self.baseScrollView setDirectionalLockEnabled:YES];
    
    self.baseScrollView.scrollEnabled = YES;
    
    [self.view addSubview:self.baseScrollView];
    [self.view addSubview:self.segControl];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    NSUInteger selectedIndex = sender.selectedSegmentIndex;
    [self.baseScrollView setContentOffset:CGPointMake(selectedIndex * CGRectGetWidth(self.view.frame), self.baseScrollView.contentOffset.y) animated:YES];
}

- (void) updateData:(UIRefreshControl *)control {
    
    UITableView *tableView = [self.tableArr objectAtIndex:control.tag];
    [tableView reloadData];
    
    [control endRefreshing];
}

#pragma mark - ScrolLView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.baseScrollView) {
        [self.segControl setSelectedSegmentIndex:nearbyintf(fabs(scrollView.contentOffset.x)/(CGRectGetWidth(self.view.frame)))];
    }
}

#pragma mark - Table Datasource / Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger numRows = 0;
    switch(tableView.tag) {
        case 0:
            numRows = self.dataArr.count;
            break;
        case 1:
            numRows = self.letterArr.count;
            break;
        case 2:
            numRows = self.randomArr.count;
            break;
        default:
            numRows = 0;
            break;
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"sampleCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    switch(tableView.tag) {
        case 0:
            cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [self.letterArr objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = [self.randomArr objectAtIndex:indexPath.row];
            break;
        default:
            cell.textLabel.text = @"stuff";
            break;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
