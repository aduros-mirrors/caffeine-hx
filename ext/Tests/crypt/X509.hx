import formats.der.PEM;
import crypt.RSA;
import crypt.cert.X509Certificate;

class Global {
	static public var CaKeyPem : String =
"-----BEGIN RSA PRIVATE KEY-----
MIIBOgIBAAJBAN6RwYF1nImZNwa9Koa7d3liuIeO+HArxmxEN3p4HUg4kbDeob1C
yVE0xePuDtt+PZlVtrTeKUJQP24YnETnCM8CAQMCQQCUYSuro72xEM9Z03GvJ6T7
lyWvtKWgHS7y2CT8UBOFec1k02OcND4DNgoTKciCCYEJW9IZSU+CArnbP7P3HNLL
AiEA9bUgbw2DXnw5Igpc69SbB+FasE/BhZxKr6rTATvRjkkCIQDn5IEdRXEN0CqU
vNJ2Q9T0KfFLPy6sYwF4+mYNFmo+VwIhAKPOFZ9eV5RS0MFcPfKNvK/rkcrf1lkS
3HUcjKt9Nl7bAiEAmphWE4Ogs+AcYyiMTtfjTXFLh390cuyrpfxECLmcKY8CIGC2
QYYTkMONd7WvxN1Y9qmXPJ3rkxY71Uya4AwunWwF
-----END RSA PRIVATE KEY-----";

	static public var CaCertPem : String =
"-----BEGIN CERTIFICATE-----
MIICyDCCAnKgAwIBAgIJANeNvhLQbUWCMA0GCSqGSIb3DQEBBQUAMHkxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMRAwDgYDVQQHEwdNeSBDaXR5MRQw
EgYDVQQKEwtDYWZmZWluZS1oeDEQMA4GA1UEAxMHbWFpbC5tZTEbMBkGCSqGSIb3
DQEJARYMbWVAbm8uZG9tYWluMB4XDTA4MDMwNjA5MzIxNFoXDTEzMDMwNTA5MzIx
NFoweTELMAkGA1UEBhMCQVUxEzARBgNVBAgTClNvbWUtU3RhdGUxEDAOBgNVBAcT
B015IENpdHkxFDASBgNVBAoTC0NhZmZlaW5lLWh4MRAwDgYDVQQDEwdtYWlsLm1l
MRswGQYJKoZIhvcNAQkBFgxtZUBuby5kb21haW4wWjANBgkqhkiG9w0BAQEFAANJ
ADBGAkEA3pHBgXWciZk3Br0qhrt3eWK4h474cCvGbEQ3engdSDiRsN6hvULJUTTF
4+4O2349mVW2tN4pQlA/bhicROcIzwIBA6OB3jCB2zAdBgNVHQ4EFgQU1JjJ88zN
YA6AX/+GjFnpObsS8hQwgasGA1UdIwSBozCBoIAU1JjJ88zNYA6AX/+GjFnpObsS
8hShfaR7MHkxCzAJBgNVBAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMRAwDgYD
VQQHEwdNeSBDaXR5MRQwEgYDVQQKEwtDYWZmZWluZS1oeDEQMA4GA1UEAxMHbWFp
bC5tZTEbMBkGCSqGSIb3DQEJARYMbWVAbm8uZG9tYWluggkA142+EtBtRYIwDAYD
VR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAANBAI7qG3P+eQD02k8DeYoEVwr873/H
aHbLc8LZXAQgd5I9CD4lUHTxWrWC/UQg0M7bkShCd7p/j0+Bz09qRoAmXsc=
-----END CERTIFICATE-----";

	// MD2
	static public var Verisign : String =
            "-----BEGIN CERTIFICATE-----\n"+
            "MIICNDCCAaECEAKtZn5ORf5eV288mBle3cAwDQYJKoZIhvcNAQECBQAwXzELMAkG\n"+
            "A1UEBhMCVVMxIDAeBgNVBAoTF1JTQSBEYXRhIFNlY3VyaXR5LCBJbmMuMS4wLAYD\n"+
            "VQQLEyVTZWN1cmUgU2VydmVyIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTk0\n"+
            "MTEwOTAwMDAwMFoXDTEwMDEwNzIzNTk1OVowXzELMAkGA1UEBhMCVVMxIDAeBgNV\n"+
            "BAoTF1JTQSBEYXRhIFNlY3VyaXR5LCBJbmMuMS4wLAYDVQQLEyVTZWN1cmUgU2Vy\n"+
            "dmVyIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIGbMA0GCSqGSIb3DQEBAQUAA4GJ\n"+
            "ADCBhQJ+AJLOesGugz5aqomDV6wlAXYMra6OLDfO6zV4ZFQD5YRAUcm/jwjiioII\n"+
            "0haGN1XpsSECrXZogZoFokvJSyVmIlZsiAeP94FZbYQHZXATcXY+m3dM41CJVphI\n"+
            "uR2nKRoTLkoRWZweFdVJVCxzOmmCsZc5nG1wZ0jl3S3WyB57AgMBAAEwDQYJKoZI\n"+
            "hvcNAQECBQADfgBl3X7hsuyw4jrg7HFGmhkRuNPHoLQDQCYCPgmc4RKz0Vr2N6W3\n"+
            "YQO2WxZpO8ZECAyIUwxrl0nHPjXcbLm7qt9cuzovk2C2qUtN8iD3zV9/ZHuO3ABc\n"+
            "1/p3yjkWWW8O6tO1g39NTUJWdrTJXwT4OPjr0l91X817/OWOgHz8UA==\n"+
            "-----END CERTIFICATE-----";

	// X500 Subject, for lookups.
	//"ME4xCzAJBgNVBAYTAlVTMRAwDgYDVQQKEwdFcXVpZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3Vy"+
	//"ZSBDZXJ0aWZpY2F0ZSBBdXRob3JpdHk=",
	static public var Thawte : String =
			"-----BEGIN CERTIFICATE-----\n"+
			"MIIDIDCCAomgAwIBAgIENd70zzANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJV\n"+
			"UzEQMA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2Vy\n"+
			"dGlmaWNhdGUgQXV0aG9yaXR5MB4XDTk4MDgyMjE2NDE1MVoXDTE4MDgyMjE2NDE1\n"+
			"MVowTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx\n"+
			"dWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTCBnzANBgkqhkiG9w0B\n"+
			"AQEFAAOBjQAwgYkCgYEAwV2xWGcIYu6gmi0fCG2RFGiYCh7+2gRvE4RiIcPRfM6f\n"+
			"BeC4AfBONOziipUEZKzxa1NfBbPLZ4C/QgKO/t0BCezhABRP/PvwDN1Dulsr4R+A\n"+
			"cJkVV5MW8Q+XarfCaCMczE1ZMKxRHjuvK9buY0V7xdlfUNLjUA86iOe/FP3gx7kC\n"+
			"AwEAAaOCAQkwggEFMHAGA1UdHwRpMGcwZaBjoGGkXzBdMQswCQYDVQQGEwJVUzEQ\n"+
			"MA4GA1UEChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlm\n"+
			"aWNhdGUgQXV0aG9yaXR5MQ0wCwYDVQQDEwRDUkwxMBoGA1UdEAQTMBGBDzIwMTgw\n"+
			"ODIyMTY0MTUxWjALBgNVHQ8EBAMCAQYwHwYDVR0jBBgwFoAUSOZo+SvSspXXR9gj\n"+
			"IBBPM5iQn9QwHQYDVR0OBBYEFEjmaPkr0rKV10fYIyAQTzOYkJ/UMAwGA1UdEwQF\n"+
			"MAMBAf8wGgYJKoZIhvZ9B0EABA0wCxsFVjMuMGMDAgbAMA0GCSqGSIb3DQEBBQUA\n"+
			"A4GBAFjOKer89961zgK5F7WF0bnj4JXMJTENAKaSbn+2kmOeUJXRmm/kEd5jhW6Y\n"+
			"7qj/WsjTVbJmcVfewCHrPSqnI0kBBIZCe/zuf6IWUrVnZ9NA2zsmWLIodz2uFHdh\n"+
			"1voqZiegDfqnc1zqcPGUIWVEX/r87yloqaKHee9570+sB3c4\n"+
			"-----END CERTIFICATE-----";

}

//class TestPEM extends haxe.unit.TestCase {
//}


class X509 {
	static function main()
	{
#if (FIREBUG && !neko)
		if(haxe.Firebug.detect()) {
			haxe.Firebug.redirectTraces();
		}
#end

		var x = new X509Certificate(Global.Verisign);
		//var x = new X509Certificate(Global.Thawte);
		//var x = new X509Certificate(Global.CaCertPem);
		trace(x.isSelfSigned());
		trace(x.getSubjectPrincipal());
		trace(x.getCommonName());
/*
		var r = new haxe.unit.TestRunner();
		r.add(new TestPEM());
		r.run();
*/
	}

}


