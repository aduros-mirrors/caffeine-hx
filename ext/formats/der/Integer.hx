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

/*
 * Derived from AS3 implementation Copyright (c) 2007 Henri Torgemane
 */
/**
 * Integer
 *
 * An ASN1 type for an Integer, represented with a BigInteger
 */
package formats.der;
import math.BigInteger;
import ByteString;

class Integer extends BigInteger, implements IAsn1Type
{
	private var type:Int;
	private var len:Int;

	public function new(type:Int, length:Int, b:ByteString) {
		this.type = type;
		this.len = length;
		super();
		#if CAFFEINE_DEBUG
		if(b.length <50) {
			trace(DER.indent + ByteString.hexDump(b));
		}
		#end
		var bi = BigInteger.ofByteString(b);
		bi.copyTo(this);
		#if CAFFEINE_DEBUG
		trace(DER.indent + this.toRadix(16));
		#end
	}

	public function getLength():Int
	{
		return len;
	}

	public function getType():Int
	{
		return type;
	}

	override public function toString():String {
		return DER.indent+"Integer["+type+"]["+len+"]["+super.toRadix(16)+"]";
	}

	public function toDER():ByteString {
		return null;
	}

}