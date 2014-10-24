//
//  ViewController.m
//  DeleagteTest
//
//  Created by Ivan Gol on 3/31/14.
//  Copyright (c) 2014 Adsweetcher, LLC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3092/2915896504_a88b69c9de.jpg"]]];
    [image setImage:img];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
