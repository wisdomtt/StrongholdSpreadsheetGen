//
//  AppDelegate.m
//  Upload
//
//  Created by Curtis Mason on 3/11/16.
//  Copyright © 2016 Curtis Mason. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
NSMutableData *webData;

//
//  main.m
//  SpreadsheetOfficial
//
//  Created by Curtis Mason on 3/11/16.
//  Copyright © 2016 Curtis Mason. All rights reserved.
//
int quantity = 1;

-(NSDictionary*)Information:(NSString*)title{
    if((title != nil)&&(![title isEqual:@""])){
    NSString* path = [NSString stringWithFormat:@"/Users/CurtisMason/Library/Developer/CoreSimulator/Devices/BF2B4C98-0D1B-498C-B878-C6C9912A87F0/data/Containers/Data/Application/6AF0DACC-C499-4FEA-A641-70B9A273C4DD/Documents/RecievedScouting/%@", title];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSDictionary *fileContent = [NSDictionary dictionaryWithContentsOfURL:url];
        return fileContent;
    }else{return nil;}
}
    -(NSArray*)arrayOfFoldersInFolder:(NSString*) folder {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray* files = [fm directoryContentsAtPath:folder];
        NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:1000];
        
        for(NSString *file in files) {
            NSString *path = [folder stringByAppendingPathComponent:file];
            BOOL isDir = NO;
            [fm fileExistsAtPath:path isDirectory:(&isDir)];
            if(isDir) {
                [directoryList addObject:file];
                NSLog(@"Printing stuff: %@", file);
            }
        }
        
        return directoryList;
    }
- (NSArray*)scanPath:(NSString *) sPath {
    
    BOOL isDir;
    
    [[NSFileManager defaultManager] fileExistsAtPath:sPath isDirectory:&isDir];
    
    if(isDir)
    {
        NSArray *contentOfDirectory=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:sPath error:NULL];
        //NSLog(@"%@", contentOfDirectory);
        int contentcount = [contentOfDirectory count];
       // NSLog(@"Content Count: %d", contentcount);
        int i;
        for(i=0;i<contentcount;i++)
        {
            NSString *fileName = [contentOfDirectory objectAtIndex:i];
            NSString *path = [sPath stringByAppendingFormat:@"%@%@",@"/",fileName];
            
            
            if([[NSFileManager defaultManager] isDeletableFileAtPath:path])
            {
                //NSLog(path);
                [self scanPath:path];
            }
        }
        NSLog(@"Number of items: %d", i);
        
       // quantity = i;
        return contentOfDirectory;
        
    }
    else
    {
        NSString *msg=[NSString stringWithFormat:@"%@",sPath];
       // NSLog(msg);
    }
    return nil;
}
-(NSString*)Digest:(NSDictionary*)info{
    NSString* item = [NSString stringWithFormat:@"entry.813025841=%@", [info objectForKey:@"Team Number"]];
    item = [NSString stringWithFormat:@"%@&entry.777222975=%@", item, [info objectForKey:@"Match Number"]];
    if([[info objectForKey:@"Courtyard"] isEqual:@"1"]){
        item = [NSString stringWithFormat:@"%@&entry.261331349=%@", item, [info objectForKey:@"Courtyard"]];
    }else if([[info objectForKey:@"Neutral Zone"] isEqual: @"1"]){
        item = [NSString stringWithFormat:@"%@&entry.261331349=%@", item, [info objectForKey:@"Neutral Zone"]];
    }else if([[info objectForKey:@"Spy Box"] isEqual:@"1"]){
        item = [NSString stringWithFormat:@"%@&entry.261331349=%@", item, [info objectForKey:@"Spy Box"]];
    }
    NSString *etc = @"";
    if([[info objectForKey:@"Crossed a defense"] isEqual:@"1"]){
        etc = [NSString stringWithFormat:@"%@Crossed a defense,", etc];
    }
    if([[info objectForKey:@"Reached a defense"] isEqual:@"1"]){
        etc = [NSString stringWithFormat:@"%@Reached a defense,", etc];
    }if([[info objectForKey:@"Low Goal"] isEqual:@"1"]){
        etc = [NSString stringWithFormat:@"%@Low Goal,",etc];
    }if([[info objectForKey:@"High Goal"] isEqual:@"1"]){
        etc = [NSString stringWithFormat:@"%@High Goal,", etc];
    }
    item = [NSString stringWithFormat:@"%@&entry.1457582528=%@", item, etc];
    item = [NSString stringWithFormat:@"%@&entry.692810015=%@", item, [info objectForKey:@"Cheval De Frise"]];
    item = [NSString stringWithFormat:@"%@&entry.1022071610=%@", item, [info objectForKey:@"Draw Bridge"]];
    item = [NSString stringWithFormat:@"%@&entry.2105397300=%@", item, [info objectForKey:@"Low Bar"]];
    item = [NSString stringWithFormat:@"%@&entry.232625040=%@", item, [info objectForKey:@"Moat"]];
    item = [NSString stringWithFormat:@"%@&entry.948750806=%@", item, [info objectForKey:@"Portcullis"]];
    item = [NSString stringWithFormat:@"%@&entry.997255660=%@", item, [info objectForKey:@"Rockwall"]];
    item = [NSString stringWithFormat:@"%@&entry.1269434723=%@", item, [info objectForKey:@"Rough Terrain"]];
    item = [NSString stringWithFormat:@"%@&entry.1510219932=%@", item, [info objectForKey:@"Sally Port"]];
    item = [NSString stringWithFormat:@"%@&entry.810830027=%@", item, [info objectForKey:@"Ramparts"]];
    item = [NSString stringWithFormat:@"%@&entry.922677734=%@", item, [info objectForKey:@"High Goals"]];
    item = [NSString stringWithFormat:@"%@&entry.1434193940=%@", item, [info objectForKey:@"Low Goals"]];
    NSString *etc2 = @"";
    if([[info objectForKey:@"Ground"]isEqual:@"1"]){
        etc2 = [NSString stringWithFormat:@"%@Ground,",etc2];
    }if([[info objectForKey:@"Secret Passage"]isEqual:@"1"]){
        etc2 = [NSString stringWithFormat:@"%@Secret Passage,", etc2];
    }if([[info objectForKey:@"Pre-Loaded"]isEqual:@"1"]){
        etc2= [NSString stringWithFormat:@"%@Pre Loaded,", etc2];
    }
    item = [NSString stringWithFormat:@"%@&entry.2032659013=%@", item, etc2];
    
    NSString* etc3 = @"";
    if([[info objectForKey:@"Red Card"]isEqual:@"1"]){
        etc3 = [NSString stringWithFormat:@"%@Red Card,",etc3];
    }if([[info objectForKey:@"Foul"]isEqual:@"1"]){
        etc3 = [NSString stringWithFormat:@"%@Foul,", etc3];
    }if([[info objectForKey:@"Yellow Card"]isEqual:@"1"]){
        etc3= [NSString stringWithFormat:@"%@Yellow Card,", etc3];
    }if([[info objectForKey:@"Technical Foul"]isEqual:@"1"]){
        etc3= [NSString stringWithFormat:@"%@Technical Foul,", etc3];
    }
    item = [NSString stringWithFormat:@"%@&entry.1557361793=%@", item, etc3];
    item = [NSString stringWithFormat:@"%@&entry.1459319659=%@", item, [info objectForKey:@"Total Score"]];
    item = [NSString stringWithFormat:@"%@&entry.1784012999=%@", item, [info objectForKey:@"Robot Comments"]];
    item = [NSString stringWithFormat:@"%@&entry.292897778=%@", item, [info objectForKey:@"Driver Comments"]];


    return item;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSString* PATHING = @"/Users/CurtisMason/Library/Developer/CoreSimulator/Devices/BF2B4C98-0D1B-498C-B878-C6C9912A87F0/data/Containers/Data/Application/6AF0DACC-C499-4FEA-A641-70B9A273C4DD/Documents/RecievedScouting/";
    
    NSArray* Items = [self scanPath:PATHING];
    while(true){
    NSLog(@"%@", Items);
    NSDictionary* dict = [self Information:[Items objectAtIndex:quantity]];
   // NSLog(@"%@", [self Information:[Items objectAtIndex:20]]);
  
    
    
    
    
    NSString *post = [self Digest:dict];
        
        
   // NSString *post = [self Digest:dict];
   // NSLog(@"Look %@",postData);
  //  NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/a/sitechhs.com/forms/d/1oMsU1j7rU6y0jRbHge99vbbrfOBezkRrH6o_1RYMF1g/formResponse"];

    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
  //  [request setURL:[NSURL URLWithString:@"https://docs.google.com/a/sitechhs.com/forms/d/1oMsU1j7rU6y0jRbHge99vbbrfOBezkRrH6o_1RYMF1g/formResponse"]];
    [request setHTTPMethod:@"POST"];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   // NSString* postData = [self Digest:i]
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
  //  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
  //  NSLog(@"SPECIAL: %@", post);
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(theConnection) {
        webData = [NSMutableData data];
        NSLog(@"connection initiated");
    }
    [theConnection start];
        quantity++;
    
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application

}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    [webData appendData:data];
 //   NSLog(@"connection received data");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   // NSLog(@"connection received response");
    NSHTTPURLResponse *ne = (NSHTTPURLResponse *)response;
    if([ne statusCode] == 200) {
        NSLog(@"connection state is 200 - all okay");
    } else {
        NSLog(@"connection state is NOT 200");
    }
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
   // NSLog(@"Conn Err: %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Conn finished loading");
    NSString *html = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
   // NSLog(@"OUTPUT:: %@", html);
}
@end
