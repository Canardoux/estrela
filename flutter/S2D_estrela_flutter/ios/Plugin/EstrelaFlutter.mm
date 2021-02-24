/* (EstrelaFlutter.mm)
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

#import "EstrelaFlutter.h"

#include <CoronaRuntime.h>
#import <UIKit/UIKit.h>

// ----------------------------------------------------------------------------
//static FlutterEngine* flutterEngine = nil;
UIViewController* flutterViewController = nil;

class EstrelaFlutter
{
	public:
		typedef EstrelaFlutter Self;

	public:
		static const char kName[];
		static const char kEvent[];

	protected:
		EstrelaFlutter();

	public:
		bool Initialize( CoronaLuaRef listener );

	public:
		CoronaLuaRef GetListener() const { return fListener; }

	public:
		static int Open( lua_State *L );

	protected:
		static int Finalizer( lua_State *L );

	public:
		static Self *ToLibrary( lua_State *L );

	public:
		static int init( lua_State *L );
		static int show( lua_State *L );
                static int modal( lua_State *L );
                static int push( lua_State *L );
                static int pop( lua_State *L );
                static int swap( lua_State *L );


	private:
		CoronaLuaRef fListener;
        private:
                static UIViewController* topViewController();
                static UIViewController* topViewController(UIViewController * rootViewController);
                static UIViewController* bottomViewController();
};

// ----------------------------------------------------------------------------

// This corresponds to the name of the library, e.g. [Lua] require "plugin.library"
const char EstrelaFlutter::kName[] = "estrela.flutter";

// This corresponds to the event name, e.g. [Lua] event.name
const char EstrelaFlutter::kEvent[] = "estrelaflutterevent";

EstrelaFlutter::EstrelaFlutter()
:	fListener( NULL )
{
}

bool
EstrelaFlutter::Initialize( CoronaLuaRef listener )
{
	// Can only initialize listener once
	bool result = ( NULL == fListener );

	if ( result )
	{
		fListener = listener;
	}

	return result;
}

int
EstrelaFlutter::Open( lua_State *L )
{
	// Register __gc callback
	const char kMetatableName[] = __FILE__; // Globally unique string to prevent collision
	CoronaLuaInitializeGCMetatable( L, kMetatableName, Finalizer );

	// Functions in library
	const luaL_Reg kVTable[] =
	{
		{ "init", init },
		{ "show", show },
                { "modal", modal },
                { "push", push },
                { "pop", pop },
                { "swap", swap },


		{ NULL, NULL }
	};

	// Set library as upvalue for each library function
	Self *library = new Self;
	CoronaLuaPushUserdata( L, library, kMetatableName );

	luaL_openlib( L, kName, kVTable, 1 ); // leave "library" on top of stack

	return 1;
}

int
EstrelaFlutter::Finalizer( lua_State *L )
{
	Self *library = (Self *)CoronaLuaToUserdata( L, 1 );

	CoronaLuaDeleteRef( L, library->GetListener() );

	delete library;

	return 0;
}

EstrelaFlutter *
EstrelaFlutter::ToLibrary( lua_State *L )
{
	// library is pushed as part of the closure
	Self *library = (Self *)CoronaLuaToUserdata( L, lua_upvalueindex( 1 ) );
	return library;
}

// [Lua] library.init( listener )
int
EstrelaFlutter::init( lua_State *L )
{
	int listenerIndex = 1;

	if ( CoronaLuaIsListener( L, listenerIndex, kEvent ) )
	{
		Self *library = ToLibrary( L );

		CoronaLuaRef listener = CoronaLuaNewRef( L, listenerIndex );
		library->Initialize( listener );
	}

	return 0;
}

// [Lua] library.show( word )
int
EstrelaFlutter::show( lua_State *L )
{
/*
	NSString *message = @"Error: Could not display UIReferenceLibraryViewController. This feature requires iOS 5 or later.";
	
	if ( [UIReferenceLibraryViewController class] )
	{
		id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );

		const char kDefaultWord[] = "corona";
		const char *word = lua_tostring( L, 1 );
		if ( ! word )
		{
			word = kDefaultWord;
		}

		UIReferenceLibraryViewController *controller = [[[UIReferenceLibraryViewController alloc] initWithTerm:[NSString stringWithUTF8String:word]] autorelease];

		// Present the controller modally.
		[runtime.appViewController presentViewController:controller animated:YES completion:nil];

		message = @"Success. Displaying UIReferenceLibraryViewController for 'corona'.";
	}

	Self *library = ToLibrary( L );

	// Create event and add message to it
	CoronaLuaNewEvent( L, kEvent );
	lua_pushstring( L, [message UTF8String] );
	lua_setfield( L, -2, "message" );

	// Dispatch event to library's listener
	CoronaLuaDispatchEvent( L, library->GetListener(), 0 );

	return 0;
 */
 	NSString *message = @"Error: Could not display UIReferenceLibraryViewController. This feature requires iOS 5 or later.";
	
	if ( [UIReferenceLibraryViewController class] )
	{
		id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );

		const char kDefaultWord[] = "toto";
		const char *word = lua_tostring( L, 1 );
		if ( ! word )
		{
			word = kDefaultWord;
		}

		UIReferenceLibraryViewController *controller = [[[UIReferenceLibraryViewController alloc] initWithTerm:[NSString stringWithUTF8String:word]] autorelease];

		// Present the controller modally.
		[runtime.appViewController presentViewController:controller animated:YES completion:nil];

		message = @"Success. Displaying UIReferenceLibraryViewController for 'corona'.";
	}

	Self *library = ToLibrary( L );

	// Create event and add message to it
	CoronaLuaNewEvent( L, kEvent );
	lua_pushstring( L, [message UTF8String] );
	lua_setfield( L, -2, "message" );

	// Dispatch event to library's listener
	CoronaLuaDispatchEvent( L, library->GetListener(), 0 );

	return 0;
}


UIViewController*
EstrelaFlutter::topViewController()
{
        return topViewController ([UIApplication sharedApplication].keyWindow.rootViewController);
}


UIViewController*
EstrelaFlutter::bottomViewController()
{
        return [UIApplication sharedApplication].keyWindow.rootViewController;
}

UIViewController*
EstrelaFlutter::topViewController(UIViewController * rootViewController)
{
        if (rootViewController.presentedViewController == nil)
        {
                return rootViewController;
        }
  
        if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]])
        {
                UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
                UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
                return topViewController (lastViewController);
        }
  
        UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
        return topViewController (presentedViewController);
}

int
EstrelaFlutter::modal (lua_State* L)
{
/*
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
*/
        id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );
        UIViewController* bottom = bottomViewController();
        UIViewController* top = topViewController();
        UIViewController* titi = runtime.appViewController;
        //UIViewController* flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        [top presentViewController:flutterViewController animated:YES completion:nil];
        return 0;
}


int
EstrelaFlutter::push (lua_State* L)
{
/*
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
        */
        id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );
        UIViewController* bottom = bottomViewController();
        UIViewController* top = topViewController();
        UIViewController* titi = runtime.appViewController;
        
        UINavigationController* nav = titi.navigationController;
        //[nav setNavigationBarHidden: YES];
        //[nav pushViewController: top animated:YES];
        [nav pushViewController: flutterViewController animated:YES];
        
        return 0;
}
 

int
EstrelaFlutter::pop (lua_State* L)
{
/*
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
*/
        id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );
        UIViewController* bottom = bottomViewController();
        UIViewController* top = topViewController();
        UIViewController* titi = runtime.appViewController;
        UINavigationController* nav = titi.navigationController;
        [nav popViewControllerAnimated: YES];
        
  
        
        return 0;
}



int
EstrelaFlutter::swap (lua_State* L)
{
/*
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
*/
        id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );
        UIViewController* bottom = bottomViewController();
        UIViewController* top = topViewController();
        UIViewController* titi = runtime.appViewController;
        
        //UIViewController* flutterViewController = [flutterViewController initWithEngine:flutterEngine nibName:nil bundle:nil];
        
        return 0;

        
        /*
        UINavigationController* nav = titi.navigationController;
        UIViewController* toto = runtime.appViewController;
        if (nav == nil)
        {
                @try
                {
                        UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;;
                        nav = [ [UINavigationController alloc] initWithRootViewController: nil];
                        //nav = [UINavigationController alloc];
                        //nav.viewControllers =  @[bottom];
                        [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
                } @catch ( NSException *e )
                {
                        e = e;
                }

        }
        //[nav setNavigationBarHidden: YES];
        [nav pushViewController: top animated:YES];
        [nav pushViewController: flutterViewController animated:YES];
        */
        return 0;
}


// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------

CORONA_EXPORT int luaopen_estrela_flutter( lua_State *L )
{
	return EstrelaFlutter::Open( L );
}
