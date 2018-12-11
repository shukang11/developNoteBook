//
//  ViewController.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *contents;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contents = @[
                      @{
                          @"title": @"异步绘制文本",
                          @"clazz": @"ViewController"
                          },
                      @{
                          @"title": @"Core Graphics",
                          @"clazz": @"CoreGPage"
                          }
                      ];
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0.0, self.view.layoutMargins.top, self.view.frame.size.width, self.view.frame.size.height - self.view.layoutMargins.top);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *d = [self.contents objectAtIndex:indexPath.row];
    cell.textLabel.text = d[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *d = [self.contents objectAtIndex:indexPath.row];
    NSString *s = [d objectForKey:@"clazz"];
    UIViewController *c = [[NSClassFromString(s) alloc] init];
    c.title = [d objectForKey:@"title"];
    [self.navigationController pushViewController:c animated:YES];
}

@end
