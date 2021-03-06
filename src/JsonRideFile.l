%{
/*
 * Copyright (c) 2010 Mark Liversedge (liversedge@gmail.com)
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc., 51
 * Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include "JsonRideFile.h"

// we use stdio for reading from FILE *JsonRideFilein
// because thats what lex likes to do, and since we're
// reading files that seems ok anyway
#include <stdio.h>

// The parser defines the token values for us
// so lets include them before declaring the
// token patterns
#include "JsonRideFile_yacc.h"/* generated by the scanner */

// the options below tell flex to no bother with
// yywrap since we only ever read a single file
// anyway. And yyunput() isn't needed for our
// parser, we read in one pass with no swanky
// interactions

%}
%option noyywrap
%option nounput
%%
\"RIDE\"            return RIDE;
\"STARTTIME\"       return STARTTIME;
\"RECINTSECS\"      return RECINTSECS;
\"DEVICETYPE\"      return DEVICETYPE;
\"IDENTIFIER\"      return IDENTIFIER;
\"OVERRIDES\"       return OVERRIDES;
\"TAGS\"            return TAGS;
\"INTERVALS\"       return INTERVALS;
\"NAME\"            return NAME;
\"START\"           return START;
\"STOP\"            return STOP;
\"SAMPLES\"         return SAMPLES;
\"SECS\"            return SECS;
\"KM\"              return KM;
\"WATTS\"           return WATTS;
\"NM\"              return NM;
\"CAD\"             return CAD;
\"KPH\"             return KPH;
\"HR\"              return HR;
\"ALT\"             return ALTITUDE; // ALT clashes with qtnamespace.h:46
\"LAT\"             return LAT;
\"LON\"             return LON;
\"HEADWIND\"        return HEADWIND;
[-+]?[0-9]+            return INTEGER;
[-+]?[0-9]+e-[0-9]+    return FLOAT;
[-+]?[0-9]+\.[-e0-9]*  return FLOAT;
\"([^\"]|\\\")*\"   return STRING;  /* contains non-quotes or escaped-quotes */
[ \n\t\r]           ;               /* we just ignore whitespace */
.                   return JsonRideFiletext[0]; /* any other character, typically :, { or } */
%%
