/* (EstrelaFlutterEngineCoronaDelegate.mm)
 *
 * Copyright 2020, 2021 Canardoux <larpoux@canardoux.xyz>.
 *
 * This file is part of Estrela.
 *
 * Estrela is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3, as published by
 * the Free Software Foundation.
 *
 * Estrela is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Estrela.  If not, see <https://www.gnu.org/licenses/>.
 *
 */


#import "EstrelaFlutterEngineCoronaDelegate.h"

#import <CoronaRuntime.h>
#import <CoronaLua.h>
#include "GeneratedPluginRegistrant.h"

@interface EstrelaFlutterEngineCoronaDelegate ()
@property (nonatomic, strong) FlutterPluginAppLifeCycleDelegate* lifeCycleDelegate;
@end

@implementation EstrelaFlutterEngineCoronaDelegate

extern UIViewController* flutterViewController; // Avoid an include to another package

- (void)addApplicationLifeCycleDelegate:(NSObject<FlutterApplicationLifeCycleDelegate>*)delegate
{
    [_lifeCycleDelegate addDelegate:delegate];
}


- (instancetype)init {
    if (self = [super init]) {
        _lifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return self;
}



- (void)willLoadMain:(id<CoronaRuntime>)runtime
{
        
}

- (void)didLoadMain:(id<CoronaRuntime>)runtime
{
}

#pragma mark UIApplicationDelegate methods

// The following are stubs for common delegate methods. Uncomment and implement
// the ones you wish to be called. Or add additional delegate methods that
// you wish to be called.


- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// =======================================================================================


/**
 * Registers `delegate` to receive life cycle callbacks via this FlutterPluginAppLifecycleDelegate
 * as long as it is alive.
 *
 * `delegate` will only referenced weakly.
 */
- (void)addDelegate:(NSObject<FlutterApplicationLifeCycleDelegate>*)delegate
{
    [_lifeCycleDelegate addDelegate:delegate];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 *
 * @return `NO` if any plugin vetoes application launch.
 */
- (BOOL)application:(UIApplication*)application
    didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
    [self.flutterEngine runWithEntrypoint:nil];
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    
    flutterViewController = [[FlutterViewController alloc] initWithEngine: self.flutterEngine nibName:nil bundle:nil];

    
    return [_lifeCycleDelegate application:application didFinishLaunchingWithOptions:launchOptions];

}


// Returns the key window's rootViewController, if it's a FlutterViewController.
// Otherwise, returns nil.
- (FlutterViewController*)rootFlutterViewController {
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([viewController isKindOfClass:[FlutterViewController class]]) {
        return (FlutterViewController*)viewController;
    }
    return nil;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [super touchesBegan:touches withEvent:event];

    // Pass status bar taps to key window Flutter rootViewController.
    if (self.rootFlutterViewController != nil) {
        [self.rootFlutterViewController handleStatusBarTouches:event];
    }
}



/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 *
 * @return `NO` if any plugin vetoes application launch.
 */
- (BOOL)application:(UIApplication*)application
    willFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
[_lifeCycleDelegate application:application willFinishLaunchingWithOptions: launchOptions];
return YES;
}

/**
 * Called if this plugin has been registered for `UIApplicationDelegate` callbacks.
 */
- (void)application:(UIApplication*)application
    didRegisterUserNotificationSettings:(UIUserNotificationSettings*)notificationSettings
    API_DEPRECATED(
        "See -[UIApplicationDelegate application:didRegisterUserNotificationSettings:] deprecation",
        ios(8.0, 10.0))
{
    [_lifeCycleDelegate application:application didRegisterUserNotificationSettings:notificationSettings];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 */
- (void)application:(UIApplication*)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [_lifeCycleDelegate application:application
didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 */
- (void)application:(UIApplication*)application
    didReceiveRemoteNotification:(NSDictionary*)userInfo
          fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [_lifeCycleDelegate application:application
       didReceiveRemoteNotification:userInfo
             fetchCompletionHandler:completionHandler];
}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 */
- (void)application:(UIApplication*)application
    didReceiveLocalNotification:(UILocalNotification*)notification
    API_DEPRECATED(
        "See -[UIApplicationDelegate application:didReceiveLocalNotification:] deprecation",
        ios(4.0, 10.0))
{

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 *  @return `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options
{
    return [_lifeCycleDelegate application:application openURL:url options:options];
}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 * @return `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url
{
    return [_lifeCycleDelegate application:application handleOpenURL:url];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 * @return `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application
              openURL:(NSURL*)url
    sourceApplication:(NSString*)sourceApplication
           annotation:(id)annotation
{
    return [_lifeCycleDelegate application:application
                                   openURL:url
                         sourceApplication:sourceApplication
                                annotation:annotation];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks.
 */
- (void)application:(UIApplication*)application
    performActionForShortcutItem:(UIApplicationShortcutItem*)shortcutItem
               completionHandler:(void (^)(BOOL succeeded))completionHandler
    API_AVAILABLE(ios(9.0))
{
   [_lifeCycleDelegate application:application
       performActionForShortcutItem:shortcutItem
                  completionHandler:completionHandler];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 * @return `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application
    handleEventsForBackgroundURLSession:(nonnull NSString*)identifier
                      completionHandler:(nonnull void (^)(void))completionHandler
{
    [_lifeCycleDelegate application:application
handleEventsForBackgroundURLSession:identifier
                  completionHandler:completionHandler];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 * @returns `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application
    performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [_lifeCycleDelegate application:application performFetchWithCompletionHandler:completionHandler];

}

/**
 * Calls all plugins registered for `UIApplicationDelegate` callbacks in order of registration until
 * some plugin handles the request.
 *
 * @return `YES` if any plugin handles the request.
 */
- (BOOL)application:(UIApplication*)application
    continueUserActivity:(NSUserActivity*)userActivity
      restorationHandler:(void (^)(NSArray*))restorationHandler
{

}

// ============================================================================================


@end
