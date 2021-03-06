/*
 * Copyright (c) 2008, The Caffeine-hx project contributors
 * Original author : Ritchie Turner, Copyright (c) 2007 ritchie@blackdog-haxe.com
 * Contributors: Russell Weir, Danny Wilson
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE CAFFEINE-HX PROJECT CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE CAFFEINE-HX PROJECT CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/*
 * The Software shall be used for Good, not Evil.
 *
 * Updated for haxe by ritchie turner
 * Copyright (c) 2007 ritchie@blackdog-haxe.com
 *
 * There are control character things I didn't bother with.
 */

/*
 * Danny: added control character support based on: http://www.json.org/json2.js
 */

package formats.json;

/**
	JSON format encoding and decoding.
**/
class JSON {
	/**
		Encode an object to JSON
	**/
	public static inline function encode(v:Dynamic) : String {
		return Encode.convertToString(v);
	}

	/**
		Decode a string to an Object
	**/
	public static inline function decode(v:String) : Dynamic {
		return new JsonDecoder().parse(v);
	}
}

private class Encode {

	public static function convertToString(value:Dynamic):String {
		if (value == null)					return "null";
		if (Std.is(value,String))			return escapeString(Std.string(value));
		else if (Std.is(value,Float))		return Math.isFinite(value) ? Std.string(value) : "null";
		else if (Std.is(value,Bool))		return value ? "true" : "false";
		else if (Std.is(value,Array))		return arrayToString(value);
		else if (Std.is(value,List))		return listToString(value);
		else if (Reflect.isObject(value))	return objectToString( value );

		throw new JsonException("JSON.encode() failed");
	}

	private static function escapeString( str:String ):String {
		var ch:Int;
		var s = new StringBuf();
		var addChar = s.addChar;

		for (i in 0 ... str.length){
			#if neko
				ch = neko.Utf8.charCodeAt(str, i);
			#else true
				ch = str.charCodeAt(i);
			#end
			switch ( ch ) {
				case 34:	s.add('\\"');	// quotation mark	"
				case 92:	s.add("\\\\");	// reverse solidus	\
				case 8:		s.add("\\b");	// backspace		\b
				case 12:	s.add("\\f");	// form feed		\f
				case 10:	s.add("\\n");	// newline			\n
				case 13:	s.add("\\r");	// carriage return	\r
				case 9:		s.add("\\t");	// horizontal tab	\t
				default:
					if( (ch >= 0 && ch <= 31)			/* \x00-\x1f */
					 || (ch >= 127 && ch <= 159)		/* \x7f-\x9f */
					 ||  ch == 173						/* \u00ad */
					 ||  ch >= 1536 && 					// -- Breaks the if sooner :-)
						(    ch <= 1540					/* \u0600-\u0604 */
						||  ch == 1807					/* \u070f */
						||  ch == 6068					/* \u17b4 */
						||  ch == 6069					/* \u17b5 */
						|| (ch >= 8204 && ch <= 8207)	/* \u200c-\u200f */
						|| (ch >= 8232 && ch <= 8239)	/* \u2028-\u202f */
						|| (ch >= 8288 && ch <= 8303)	/* \u2060-\u206f */
						||  ch == 65279					/* \ufeff */
						|| (ch >= 65520 && ch <= 65535)	/* \ufff0-\uffff */
						)
					) s.add("\\u" + StringTools.hex(ch, 4));

					addChar(ch);
			}

		}

		return "\"" + s.toString() + "\"";
	}

	private static function arrayToString( a:Array<Dynamic> ):String {
		var s = new StringBuf();
		for(i in 0 ... a.length) {
			s.add(convertToString( a[i] ));
			s.add(",");
		}
		return "[" + s.toString().substr(0,-1) + "]";
	}

	private static function objectToString( o:Dynamic):String {
		var s = new StringBuf();
		if ( Reflect.isObject(o)) {
			if (Reflect.hasField(o,"__cache__")) {
				// TODO, probably needs revisiting
				// hack for spod object ....
				o = Reflect.field(o,"__cache__");
			}
			var value:Dynamic;
			var sortedFields = Reflect.fields(o);
			sortedFields.sort(function(k1, k2) { return (k1 == k2) ? 0 : (k1 < k2) ? -1 : 1; });
			for (key in sortedFields) {
				value = Reflect.field(o,key);

				if (Reflect.isFunction(value))
					continue;

				s.add(escapeString( key ) + ":" + convertToString( value ));
				s.add(",");
			}
		}
		else {
			for(v in Reflect.fields(o)) {
				s.add(escapeString(v) + ":" + convertToString( Reflect.field(o,v) ));
				s.add(",");
			}
			var sortedFields = Reflect.fields(o);
			sortedFields.sort(function(k1, k2) { if (k1 == k2) return 0; if (k1 < k2) return -1; return 1;});

			for(v in sortedFields) {
				s.add(escapeString(v) + ":" + convertToString( Reflect.field(o,v)));
				s.add(",");
			}
		}
		return "{" + s.toString().substr(0,-1) + "}";
	}

	private static function listToString( l: List<Dynamic>) :  String {
		var s:StringBuf = new StringBuf();
		var i:Int= 0;

		for(v in l) {
		s.add(convertToString( v ));
		s.add(",");
		}

		return "[" + s.toString().substr(0,-1) + "]";
	}
}

