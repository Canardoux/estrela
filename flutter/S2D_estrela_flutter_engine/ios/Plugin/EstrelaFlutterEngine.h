/* (EstrelaFlutterEngine.h)
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


#ifndef _EstrelaFlutterEngine_H__
#define _EstrelaFlutterEngine_H__

#include <CoronaLua.h>
#include <CoronaMacros.h>

// This corresponds to the name of the library, e.g. [Lua] require "plugin.library"
// where the '.' is replaced with '_'
CORONA_EXPORT int luaopen_estrela_flutter_engine( lua_State *L );

#endif // _EstrelaFlutterEngine_H__
