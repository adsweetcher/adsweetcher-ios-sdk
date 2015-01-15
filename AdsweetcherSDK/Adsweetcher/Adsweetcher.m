//
//  adswitcher.m
//  DeleagteTest
//
//  Created by Ivan Gol on 3/31/14.
//  Copyright (c) 2014 Armele Games, LLC. All rights reserved.
//


#import "Adsweetcher.h"

@implementation Adsweetcher


@synthesize delegate;

+ (id)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

- (void) retrieveAdsNetworkSettings {
    NSString *url = [NSString stringWithFormat:@"http://www.adsweetcher.com/api/token/userid/%@",token];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLConnection* conn;
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    statusCode = [httpResponse statusCode];
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if ( statusCode != 200 ){
        NSLog( @"Service response is %zd. 200 is expected. Running default Network", statusCode  );
        [delegate defaultAdNetwork];
        return;
    }
    
    NSError *jsonParsingError = nil;
    if (!responseData) {
        [delegate defaultAdNetwork];
        return;
    }
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
    
    if (!delegate){
        NSLog( @"Delegate should be set" );
    }
    
    if (jsonParsingError) {
        NSLog(@"JSON ERROR: %@", [jsonParsingError localizedDescription]);
        [delegate defaultAdNetwork];
    } else {
        NSLog(@"OBJECT: %@", [jsonObject class]);
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        NSString* testString = [jsonDictionary objectForKey:@"ad"];
        @try{
            
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Boot", testString]);
            
            IMP imp = [delegate methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(delegate, selector);
            return;
            
            if ([delegate respondsToSelector:@selector(selector)]){
                IMP imp = [delegate methodForSelector:selector];
                void (*func)(id, SEL) = (void *)imp;
                func(delegate, selector);
            } else {
                [delegate defaultAdNetwork];
            }
            
        }@catch (NSException *exception){
            NSLog( @"NSException caught" );
            NSLog( @"Name: %@", exception.name);
            NSLog( @"Reason: %@", exception.reason );
            NSLog( @"Cannot find method: %@. Make sure it is implemented in delegated method", testString);
            [delegate defaultAdNetwork];
            return;
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog( @"Request did failed with error:%@", error.description );
}

- (void) setAppToken:(NSString*) appToken{
    token = appToken;
}


@end


