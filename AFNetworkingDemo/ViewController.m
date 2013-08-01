//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by Magnon International on 01/08/13.
//  Copyright (c) 2013 Sumit Sharma. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize movies;
@synthesize activityIndicatorView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Calling web Service
    [self startWebService];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"Cell Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    cell.textLabel.text = [movie objectForKey:@"trackName"];
    cell.detailTextLabel.text = [movie objectForKey:@"artistName"];
    
    NSURL *url = [[NSURL alloc] initWithString:[movie objectForKey:@"artworkUrl100"]];
    [cell.imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.movies && self.movies.count) {
        return self.movies.count;
    } else {
        return 0;
    }
}


#pragma mark - Call API
-(void)startWebService{
    [activityIndicatorView startAnimating];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://itunes.apple.com/search?term=harry&country=us&entity=movie"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.movies = [JSON objectForKey:@"results"];
        [activityIndicatorView stopAnimating];
        [tblView setHidden:NO];
        [tblView reloadData];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
}
@end
