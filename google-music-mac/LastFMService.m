/*
 * LastFmService.h
 *
 * Created by Sajid Anwar and Anant Narayanan.
 *
 * Subject to terms and conditions in LICENSE.md.
 *
 */

#import "LastFmService.h"

@implementation LastFmService

+ (void)scrobbleSong:(NSString *)title withArtist:(NSString *)artist album:(NSString *)album duration:(NSTimeInterval)duration timestamp:(NSTimeInterval)timestamp
{
    NSTimeInterval curTimestamp = [[NSDate date] timeIntervalSince1970];
    
    if ([title length] && curTimestamp - timestamp >= duration / 2) {
        [[LastFm sharedInstance] sendScrobbledTrack:title
                                           byArtist:artist
                                            onAlbum:album
                                       withDuration:duration
                                        atTimestamp:timestamp
                                     successHandler:^(NSDictionary *result) {
                                         return;
                                     }
                                     failureHandler:^(NSError *error) {
                                         NSLog(@"Error scrobbling song: %@, %@", error, [error userInfo]);
                                     }
         ];
    }
    
    
}

+ (void)sendNowPlaying:(NSString *)title withArtist:(NSString *)artist album:(NSString *)album duration:(NSTimeInterval)duration timestamp:(NSTimeInterval)timestamp
{
    [[LastFm sharedInstance] sendNowPlayingTrack:title
                                        byArtist:artist
                                         onAlbum:album
                                    withDuration:duration
                                  successHandler:^(NSDictionary *result) {
                                      return;
                                  }
     
                                  failureHandler:^(NSError *error) {
                                      NSLog(@"Error sending now playing song: %@, %@", error, [error userInfo]);
                                  }
     ];
}

@end
