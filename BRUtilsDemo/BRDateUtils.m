//
//  BRDateUtils.m
//  BRUtilsDemo
//
//  Created by Bobby Ren on 4/5/15.
//  Copyright (c) 2015 Bobby Ren Tech. All rights reserved.
//

#import "BRDateUtils.h"

@implementation BRDateUtils

#pragma mark Day of week
+(NSDate *)mondayOfWeekForDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    [cal setFirstWeekday:2]; // forces monday to be the beginning of the week, so that sunday of the week is after monday of the week
    [cal setTimeZone:[NSTimeZone localTimeZone]];

    NSTimeInterval extends;
    NSDate *monday;

    [cal rangeOfUnit:NSWeekCalendarUnit startDate:&monday interval: &extends forDate:date];
    return monday;
}

+(NSDate *)sundayOfWeekForDate:(NSDate *)date {
    // returns the datetime for sunday in GMT (whatever time it is for midnight sunday morning in the local timezone)
    // any date comparisons using this date must be [NSDate date]!
    NSDate *monday = [self mondayOfWeekForDate:date];
    NSDate *sunday = [monday dateByAddingTimeInterval:6*24*3600];
    return sunday;
}

#pragma mark Date formatters
static NSDateFormatter *yearMonthDayFormatter;
static NSDateFormatter *hourMinAMPMFormatter;

+(NSDateFormatter *)yearMonthDayFormatter {
    static dispatch_once_t b; dispatch_once(&b, ^{
        if (!yearMonthDayFormatter) {
            yearMonthDayFormatter = [[NSDateFormatter alloc] init];
            [yearMonthDayFormatter setDateFormat:@"yyyy-MM-dd"];
        }
    });
    return yearMonthDayFormatter;
}

+(NSDateFormatter *)hourMinAMPMFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!hourMinAMPMFormatter) {
            hourMinAMPMFormatter = [[NSDateFormatter alloc] init];
            [hourMinAMPMFormatter setDateFormat:@"h:mm a"];
        }
    });
    return hourMinAMPMFormatter;
}

#pragma mark Date format functions
+(NSString *)yearMonthDayForDate:(NSDate *)date {
    NSDateFormatter *formatter = [self yearMonthDayFormatter];
    return [formatter stringFromDate:date];
}

+(NSString *)simpleTimeForDate:(NSDate *)date {
    NSDateFormatter *formatter = [self hourMinAMPMFormatter];
    return [formatter stringFromDate:date];
}
@end
