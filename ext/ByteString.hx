/*
 * Copyright (c) 2008, The Caffeine-hx project contributors
 * Original author : Russell Weir
 * Contributors:
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

class ByteString extends String {

	var _buf : Array<Int>;
	public function new(?s : String) {
		super("");
		_buf = new Array();
		if(s != null) {
			for(i in 0...s.length)
				_buf.push(s.charCodeAt(i));
			length = s.length;
		}
	}

	/**
		Set position to a byte value. Only the lower 8 bits
		of the integer are used. Attempts to set values beyond
		the buffer length will throw an exception. Setting
	**/
	public function set(pos: Int, value:Int) {
		if(pos > _buf.length)
			throw "index error";
		_buf[pos] = value & 0xff;
		length = _buf.length;
	}

	/**
		Get the value at position pos. Same as charCodeAt
	**/
	public function get(pos : Int) : Null<Int> {
		if(pos >= _buf.length || pos < 0)
			throw "index error";
		return _buf[pos];
	}

	/**
		Alias for set.
	**/
	public function setCodeAt(pos: Int, value:Int) : Void {
		set(pos, value);
	}

	override public function charAt( index : Int ) : String {
		return Std.chr(_buf[index]);
	}

	override public function charCodeAt( index : Int ) : Null<Int> {
		var a : Null<Int> = get(index);
		return a;
	}

	override public function toString() : String {
		var sb = new StringBuf();
		for(x in 0..._buf.length)
			sb.addChar(_buf[x]);
		return sb.toString();
	}

	override public function toUpperCase() : String {
		throw "unimplemented";
		return "";
	}

	override public function toLowerCase() : String {
		throw "unimplemented";
		return "";
	}

	override public function indexOf( value : String, ?startIndex : Int ) : Int {
		return toString().indexOf(value, startIndex);
	}

	override public function lastIndexOf( value : String, ?startIndex : Int ) : Int {
		return toString().indexOf(value, startIndex);
	}

	/**
		Removes the last byte and returns it.
	**/
	public function pop() : Null<Int> {
		if(_buf.length == 0) {
			length = 0;
			return null;
		}
		length--;
		return _buf.pop();
	}

	/**
		Adds a byte to the end of the buffer. Returns the
		new length.
	**/
	public function push(v : Int) : Int {
		_buf.push(v & 0xFF);
		length = _buf.length;
		return length;
	}

	/**
		Removes the last byte and returns it.
	**/
	public function shift() : Null<Int> {
		var r = _buf.shift();
		length = _buf.length;
		return r;
	}

	override public function split( delimiter : String ) : Array<String> {
		return toString().split( delimiter );
	}

	/**
		Split a ByteString into an array of ByteStrings. The delimiter may
		be another ByteString;
	**/
	public function splitB( delimiter : String ) : Array<ByteString> {
		var a = toString().split( delimiter.toString() );
		var r = new Array<ByteString>();
		for( i in a )
			r.push(new ByteString(i));
		return r;
	}

	override public function substr( pos : Int, ?len : Int ) : String {
		return toString().substr( pos, len );
	}

	/**
		Return a ByteString slice
	**/
	public function substrB( pos : Int, ?len : Int ) : ByteString {
		return new ByteString(toString().substr( pos, len ));
	}

	/**
		Add a byte to the beginning of the buffer.
	**/
	public function unshift(v : Int ) : Void {
		var r = _buf.unshift(v);
		length = _buf.length;
		return r;
	}

}

