/*
 * Copyright (c) 2005, The haXe Project Contributors
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
 * THIS SOFTWARE IS PROVIDED BY THE HAXE PROJECT CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE HAXE PROJECT CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
package neko;

typedef FileStat = {
	var gid : Int;
	var uid : Int;
	var atime : Date;
	var mtime : Date;
	var ctime : Date;
	var dev : Int;
	var ino : Int;
	var nlink : Int;
	var rdev : Int;
	var size : Int;
	var mode : Int;
}

enum FileKind {
	kdir;
	kfile;
	kother( k : String );
}

class FileSystem {

	public static function exists( path : String ) : Bool {
		return sys_exists(untyped path.__s);
	}

	public static function rename( path : String, newpath : String ) {
		untyped sys_rename(path.__s,newpath.__s);
	}

	public static function stat( path : String ) : FileStat {
		var s : FileStat = sys_stat(untyped path.__s);
		s.atime = untyped Date.new1(s.atime);
		s.mtime = untyped Date.new1(s.mtime);
		s.ctime = untyped Date.new1(s.ctime);
		return s;
	}

	public static function fullPath( relpath : String ) : String {
		return new String(file_full_path(untyped relpath.__s));
	}

	public static function kind( path : String ) : FileKind {
		var k = new String(sys_file_type(untyped path.__s));
		return switch(k) {
		case "file": kfile;
		case "dir": kdir;
		default: kother(k);
		}
	}

	public static function isDirectory( path : String ) : Bool {
		return kind(path) == kdir;
	}

	//BEGINPR/rw01/2008-02-07//Russell Weir/Function created
	public static function isFile( path : String ) : Bool {
		return kind(path) == kfile;
	}
	//ENDPR/rw01///

	public static function createDirectory( path : String ) {
		sys_create_dir( untyped path.__s, 493 );
	}

	public static function deleteFile( path : String ) {
		file_delete(untyped path.__s);
	}

	public static function deleteDirectory( path : String ) {
		sys_remove_dir(untyped path.__s);
	}

	public static function readDirectory( path : String ) : Array<String> {
		var l : Array<Dynamic> = sys_read_dir(untyped path.__s);
		var a = new Array();
		while( l != null ) {
			a.push(new String(l[0]));
			l = l[1];
		}
		return a;
	}

	private static var sys_exists = Lib.load("std","sys_exists",1);
	private static var file_delete = Lib.load("std","file_delete",1);
	private static var sys_rename = Lib.load("std","sys_rename",2);
	private static var sys_stat = Lib.load("std","sys_stat",1);
	private static var sys_file_type = Lib.load("std","sys_file_type",1);
	private static var sys_create_dir = Lib.load("std","sys_create_dir",2);
	private static var sys_remove_dir = Lib.load("std","sys_remove_dir",1);
	private static var sys_read_dir = Lib.load("std","sys_read_dir",1);
	private static var file_full_path = Lib.load("std","file_full_path",1);

}
