/* (EstrelaFlutterEngineCoronaDelegate.h)
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

#import <Foundation/Foundation.h>

#import <CoronaDelegate.h>
#import <Flutter/Flutter.h>


@interface EstrelaFlutterEngineCoronaDelegate : NSObject< CoronaDelegate, FlutterAppLifeCycleProvider>
//@interface EstrelaFlutterEngineCoronaDelegate : FlutterAppDelegate< CoronaDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) FlutterEngine *flutterEngine;
@end
