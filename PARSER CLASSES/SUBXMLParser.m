//
//  SUBXMLParser.m
//  ETutorialMaster
//
//  Created by Neeraj on 9/27/13.
//  Copyright (c) 2013 Subin. All rights reserved.
//

#import "SUBXMLParser.h"
#import "SUBUser.h"

@implementation SUBXMLParser
@synthesize user,users;

-(SUBXMLParser *) initXMLParser {
    
    [super self];
    users=[[NSMutableArray alloc]init];
    return self;
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
  
    if(!currentElementValue){
        currentElementValue=[[NSMutableString alloc]initWithString:string];
    }else{
        [currentElementValue appendString:string];
    }
    NSLog(@"Processing value for: %@",string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"CreateUserAccountResult"]){
        loginValue=[[NSMutableString alloc]initWithString:currentElementValue];
        
    }
    currentElementValue=nil;
}


@end
