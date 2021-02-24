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


#import "EstrelaFlutterEngine.h"

#include <CoronaRuntime.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "EstrelaFlutterEngineCoronaDelegate.h"

// Declaration
//FOUNDATION_EXPORT void CoronaSetDelegateClass( Class c );


// ----------------------------------------------------------------------------

class EstrelaFlutterEngine
{
	public:
		typedef EstrelaFlutterEngine Self;

	public:
		static const char kName[];
		static const char kEvent[];

	protected:
		EstrelaFlutterEngine();

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

	private:
		CoronaLuaRef fListener;
};

// ----------------------------------------------------------------------------

// This corresponds to the name of the library, e.g. [Lua] require "plugin.library"
const char EstrelaFlutterEngine::kName[] = "estrela.flutter.engine";

// This corresponds to the event name, e.g. [Lua] event.name
const char EstrelaFlutterEngine::kEvent[] = "estrelaflutterengineevent";

EstrelaFlutterEngine::EstrelaFlutterEngine()
:	fListener( NULL )
{
}

bool
EstrelaFlutterEngine::Initialize( CoronaLuaRef listener )
{
	// Can only initialize listener once
	bool result = ( NULL == fListener );

	if ( result )
	{
		fListener = listener;
	}
        //CoronaSetDelegateClass( [EstrelaFlutterEngineCoronaDelegate class] );
        
	return result;
}

int
EstrelaFlutterEngine::Open( lua_State *L )
{
        //CoronaSetDelegateClass( [EstrelaFlutterEngineCoronaDelegate class] );

	// Register __gc callback
	const char kMetatableName[] = __FILE__; // Globally unique string to prevent collision
	CoronaLuaInitializeGCMetatable( L, kMetatableName, Finalizer );

	// Functions in library
	const luaL_Reg kVTable[] =
	{
		{ "init", init },
		{ "show", show },

		{ NULL, NULL }
	};

	// Set library as upvalue for each library function
	Self* library = new Self;
        library ->init(L); // Is it necessary ? Added by [LARPOUX]
	CoronaLuaPushUserdata( L, library, kMetatableName );

	luaL_openlib( L, kName, kVTable, 1 ); // leave "library" on top of stack

	return 1;
}

int
EstrelaFlutterEngine::Finalizer( lua_State *L )
{
	Self *library = (Self *)CoronaLuaToUserdata( L, 1 );

	CoronaLuaDeleteRef( L, library->GetListener() );

	delete library;

	return 0;
}

EstrelaFlutterEngine *
EstrelaFlutterEngine::ToLibrary( lua_State *L )
{
	// library is pushed as part of the closure
	Self *library = (Self *)CoronaLuaToUserdata( L, lua_upvalueindex( 1 ) );
	return library;
}

// [Lua] library.init( listener )
int
EstrelaFlutterEngine::init( lua_State *L )
{
        //CoronaSetDelegateClass( [EstrelaFlutterEngineCoronaDelegate class] );
	int listenerIndex = 1;

	if ( CoronaLuaIsListener( L, listenerIndex, kEvent ) )
	{
		Self* library = ToLibrary( L );

		CoronaLuaRef listener = CoronaLuaNewRef( L, listenerIndex );
		library ->Initialize( listener );
	}

	return 0;
}

// [Lua] library.show( word )
int
EstrelaFlutterEngine::show( lua_State *L )
{
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
}

// ----------------------------------------------------------------------------

CORONA_EXPORT int luaopen_estrela_flutter_engine( lua_State *L )
{
	return EstrelaFlutterEngine::Open( L );
}
