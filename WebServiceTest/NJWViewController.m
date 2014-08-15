//
//  NJWViewController.m
//  WebServiceTest
//
//  Created by Nick Woodward on 8/13/14.
//  Copyright (c) 2014 softwaremerchant. All rights reserved.
//

#import "NJWViewController.h"
#import "SUBXMLParser.h"

@interface NJWViewController ()

@end

@implementation NJWViewController
{
    NSMutableData *responseData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    NSString *UserID = self.tfUserName.text;

    NSString *Password = self.tfPassword.text;

    NSString *UpdateIfExists = @"0";
    
    NSString *envelopeText=
    @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n"
    "  <soap12:Body>\n"
    "    <CreateUserAccount xmlns=\"http://tempuri.org/\">\n"
    "      <UserID>%@</UserID>\n"
    "      <Password>%@</Password>\n"
    "      <UpdateIfExists>%@</UpdateIfExists>\n"
    "    </CreateUserAccount>\n"
    "  </soap12:Body>\n"
    "</soap12:Envelope>";
    
    envelopeText = [NSString stringWithFormat:envelopeText, UserID,Password,UpdateIfExists];
    
    NSData *envelope = [envelopeText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url=@"http://www.softwaremerchant.com/OnlineCourse.asmx";
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:envelope];
    [request setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d",[envelope length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if(connection)
        responseData=[NSMutableData data];
    else
        NSLog(@"NSURLConnection initWithRequest: Failed to return a connection");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    [responseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [responseData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error

{
    NSLog(@"connection didFailWithError: %@ %@",
          error.localizedDescription,
          
          [error.userInfo objectForKey:NSURLErrorFailingURLStringErrorKey]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    // extract result using regular expression (only as an example)
    // this is not a good way to do it; should use XPath queries with XML DOM such as GDataXMLDocument
    NSString *responseText = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    //    _passedText.text=responseText;
    
    NSLog(@"%@",responseText);
    [self doParse:responseData];
    
}


-(void)doParse:(NSData *)data{
    NSXMLParser *nsXmlParser=[[NSXMLParser alloc]initWithData:data];
    
    SUBXMLParser *parser=[[SUBXMLParser alloc]initXMLParser];
    
    [nsXmlParser setDelegate:parser];
    
    
    [nsXmlParser parse];
    
    //Disect XML ressults for user id and password validity
    //[user setValue:currentElementValue forKey:elementName];
    NSString *string = [parser valueForKey:@"loginValue"];
    
    //self.validateduser = 0;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Account Creation" message:string delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
}
@end
