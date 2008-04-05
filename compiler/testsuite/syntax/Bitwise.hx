package syntax;

import unit.Assert;

class Bitwise {
	public function new() {}
	
	public function testSHL() {
		Assert.equals(320, 5<<6);
	}

	public function testSHR() {
		Assert.equals(5, 320>>6);
		Assert.equals(5, 320>>>6);
	}

	public function testNegSHL() {
		Assert.equals(-2048,-512 << 2);
	}

	public function testNegSHR() {
		Assert.equals(2147483136, -1024 >>> 1);
		Assert.equals(-512, -1024 >> 1);
	}

	public function testXOR() {
		Assert.equals(481923, 25968 ^ 475123);
		Assert.equals(1023, 682 ^ 341);
	}

	public function testAND() {
		Assert.equals(1024, 1024 & 1024);
		Assert.equals(0x52, 0xFF52 & 0xFF);
		Assert.equals(0xFF00, 0xFF52 & 0xFF00);
	}

	public function testOR() {
		Assert.equals(1024, 1024 | 1024);
		Assert.equals(0xFFFF, 0xFF52 | 0xFF);
		Assert.equals(0xFF52, 0xFF52 | 0xFF00);
		Assert.equals(0xFF52, 0xFF00 | 0x52);
	}  
  
  public function testSHLAssign() {
    var x = 5;
    x <<= 6;
		Assert.equals(320, x);
	}

	public function testSHRAssign() {
    var x = 320;
    x >>= 6;
		Assert.equals(5, x);
    
    x = 320;
    x >>>= 6;
    
		Assert.equals(5, x);
	}

	public function testNegSHLAssign() {
    var x = -512;
    x <<= 2;    
		Assert.equals(-2048, x);
	}

	public function testNegSHRAssign() {
    var x = -1024;
    x >>>= 1;
		Assert.equals(2147483136, x);
    x = -1024;
    x >>= 1;
		Assert.equals(-512, x);
	}

	public function testXORAssign() {
    var x = 475123;
    x ^= 25968;
		Assert.equals(481923, x);
    x = 341;
    x ^= 682;
		Assert.equals(1023, x);
	}

	public function testANDAssign() {
    var x = 1024;
    x &= 1024;
		Assert.equals(1024, x);
    x = 0xFF52;
    x &= 0xFF;
		Assert.equals(0x52, x);
    x = 0xFF52;
    x &= 0xFF00;
		Assert.equals(0xFF00, x);
	}

	public function testORAssign() {
    var x = 1024;
    x |= 1024;
		Assert.equals(1024, x);
    x = 0xFF52;
    x |= 0xFF;
		Assert.equals(0xFFFF, x);
    x = 0xFF52;
    x |= 0xFF00;
		Assert.equals(0xFF52, x);
    x = 0xFF00;
    x |= 0x52;
		Assert.equals(0xFF52, x);
	}
}
