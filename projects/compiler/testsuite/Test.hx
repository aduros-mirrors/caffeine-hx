class Test {
	public static function main() {
		var runner = new unit.Runner();  	
#if (php || neko)
		runner.register(new testneutral.TestSPOD());
		runner.register(new testneutral.TestFileSystem());
		runner.register(new testneutral.TestMysqlDb());
		runner.register(new testneutral.TestSQLiteDb());
#end
		runner.register(new syntax.AnonymousObject());
		runner.register(new syntax.ArraySyntax());
		runner.register(new syntax.Bitwise());
		runner.register(new syntax.Callback());
		runner.register(new syntax.Casts());		
		// reformulate some of this tests since other tests (from ClassDefAccess) can modify the results
		runner.register(new syntax.DynamicFunction());		
		runner.register(new syntax.ClassDefAccess());
		runner.register(new syntax.ClassInheritance());
		runner.register(new syntax.CodeBlocks());		
		runner.register(new syntax.DynamicClass());
		runner.register(new syntax.EnumAccess());
		runner.register(new syntax.EnumSyntax());
		runner.register(new syntax.EqualityOperators());
		runner.register(new syntax.Extensions());
		runner.register(new syntax.ForAccess());
		runner.register(new syntax.IfAccess());
		runner.register(new syntax.InterfaceAccess());
		runner.register(new syntax.IntIteratorAccess());
		runner.register(new syntax.MagicMethods());
		runner.register(new syntax.NativeString());
		runner.register(new syntax.NativeArray());
#if php
		runner.register(new syntax.PhpDollarEscape());
		runner.register(new syntax.PhpReservedWords());
#end
		runner.register(new syntax.PrivateClassAccess());
		runner.register(new syntax.PropertyAccess());
		runner.register(new syntax.SwitchCaseAccess());
		runner.register(new syntax.TryCatch());
		runner.register(new syntax.TypedefAccess());
		runner.register(new syntax.UndefinedVariables());	
		runner.register(new syntax.UnusualConstructs());
		runner.register(new syntax.WhileAccess());
		runner.register(new stdlib.TestArray());
		runner.register(new stdlib.TestCompare());
		runner.register(new stdlib.TestDate());		
#if (flash9 || neko || php || hllua)
		runner.register(new stdlib.TestEReg());
#end
		runner.register(new stdlib.TestHash());
#if js
		runner.register(new stdlib.TestHtmlDom());
#end
		runner.register(new stdlib.TestHttp());
		runner.register(new stdlib.TestIntHash());
		runner.register(new stdlib.TestList());
		runner.register(new stdlib.TestMd5());
		runner.register(new stdlib.TestMisc());
#if neko
		runner.register(new stdlib.TestNekoSerialization());
#end
		runner.register(new stdlib.TestReflect());
		runner.register(new stdlib.TestSerialize());
		runner.register(new stdlib.TestStd());
		runner.register(new stdlib.TestString());
		runner.register(new stdlib.TestStringTools());
#if (flash9 || js || neko || php || hllua)
		runner.register(new stdlib.TestTemplate());
#end

		runner.register(new stdlib.TestUnit());
		runner.register(new stdlib.TestXml());

		runner.run();
		
#if php
		runner.print("\n\nExceution time: " + (php.Sys.cpuTime()));
#else neko
		runner.print("\n\nExceution time: " + (neko.Sys.cpuTime()));
#end
	}
}
