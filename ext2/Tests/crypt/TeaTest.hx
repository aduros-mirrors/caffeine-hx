import chx.crypt.Tea;
import chx.crypt.IMode;
import chx.crypt.ModeECB;
import chx.crypt.ModeCBC;

enum CryptMode {
	CBC;
	ECB;
}

class TeaTestFunctions extends haxe.unit.TestCase {

	public function testOne() {
		//var s = "Whoa there nellie. Have some tea";
		var s = Bytes.ofString("Message");
		var t = new Tea(Bytes.ofString("This is my passphrase"));
		var tea = new ModeECB( t );
		var e = tea.encrypt(s);
		var d = tea.decrypt(e);

		assertFalse(BytesUtil.eq(s, e));
// 		trace(BytesUtil.hexDump(s));
// 		trace(BytesUtil.hexDump(e));
// 		trace(BytesUtil.hexDump(d));

		// Test for equality of contents of Bytes objects
		assertTrue(BytesUtil.eq(s,d));
	}

	public function testEcbAll() {
		for(phrase in CommonData.phrases) {
			for(msg in CommonData.msgs) {
				assertEquals( true,
						doTestTea(Bytes.ofString(phrase), Bytes.ofString(msg), ECB)
				);
			}
		}
	}

	public function testCbcAll() {
		for(phrase in CommonData.phrases) {
			for(msg in CommonData.msgs) {
				assertEquals( true,
						doTestTea(Bytes.ofString(phrase), Bytes.ofString(msg), CBC)
				);
			}
		}
	}

	static function doTestTea(phrase : Bytes, msg : Bytes, mode) {
		var t = new Tea(phrase);
		var tea : IMode;
		switch(mode) {
		case CBC: tea = cast { var c = new ModeCBC(t); c.iv = BytesUtil.nullBytes(16); c; }
		case ECB: tea = cast new ModeECB(t);
		}
		var enc = tea.encrypt(msg);
		var dec = tea.decrypt(enc);
		if(BytesUtil.eq(dec, msg))
			return true;
		trace("FAILED: dump of msg, encrypted, decrypted: ");
		trace(BytesUtil.hexDump(msg));
		trace(BytesUtil.hexDump(enc));
		trace(BytesUtil.hexDump(dec));
		return false;
	}
}

class TeaTest {

	public static function main() {
#if (FIREBUG && ! neko)
		if(haxe.Firebug.detect()) {
			haxe.Firebug.redirectTraces();
		}
#end
		var r = new haxe.unit.TestRunner();
		r.add(new TeaTestFunctions());
		r.run();
	}
}