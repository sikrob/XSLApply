//
//  main.m
//  XSLApply
//
//  Created by Robert Sikorski on 6/24/15.
//  Copyright (c) 2015 Sikorski. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc == 4) {
            NSString* xmlDocumentPath = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding];
            NSString* xslDocumentPath = [NSString stringWithCString:argv[2] encoding:NSASCIIStringEncoding];
            NSString* outputFilePath = [NSString stringWithCString:argv[3] encoding:NSASCIIStringEncoding];
            NSError* error = [[NSError alloc] init];

            NSXMLDocument* xmlDocument = [[NSXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:xmlDocumentPath]
                                                                     options:NSXMLDocumentValidate
                                                                       error:&error];
            NSXMLDocument* transformedDocument = [xmlDocument objectByApplyingXSLT:[NSData dataWithContentsOfFile:xslDocumentPath]
                                                                         arguments:nil
                                                                             error:&error];

            if (error) {
                NSLog(@"Input error: %@", [error description]);
            } else {
                NSData* newXML = [transformedDocument XMLDataWithOptions:NSXMLNodePrettyPrint];

                if (![newXML writeToFile:outputFilePath atomically:YES]) {
                    NSLog(@"Error in writing file.");
                }
            }
        } else {
            NSLog(@"XSLApply requires 3 arguments: (1)XML input for (2)XSL stylesheet to produce an output file at the (3)designated output path.");
        }
    }
    return 0;
}
