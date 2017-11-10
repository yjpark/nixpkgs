{ withMbedTLS ? true
, enableSystemSharedLib ? true
, stdenv, fetchurl, zlib
, openssl ? null
, mbedtls ? null
, libev ? null
, libsodium ? null
, udns ? null
, asciidoc
, xmlto
, docbook_xml_dtd_45
, docbook_xsl
, libxslt
, pcre
, c-ares
}:

let

  version = "3.1.0";
  sha256 = "3b6493ebdcfff1eb31faf34d164d57049f7253ff5bffafa6ce2263c9ac123f31";

in

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "shadowsocks-libev-${version}";
  src = fetchurl {
    url = "https://github.com/shadowsocks/shadowsocks-libev/releases/download/v${version}/shadowsocks-libev-${version}.tar.gz";
    inherit sha256;
  };

  buildInputs = [ zlib asciidoc xmlto docbook_xml_dtd_45 docbook_xsl libxslt pcre c-ares ]
                ++ optional (!withMbedTLS) openssl
                ++ optional withMbedTLS mbedtls
                ++ optionals enableSystemSharedLib [libev libsodium udns];

  configureFlags = optional withMbedTLS
                     [ "--with-mbedtls=${mbedtls}"
                     ]
                   ++ optional enableSystemSharedLib "--enable-system-shared-lib";

  meta = {
    description = "A lightweight secured SOCKS5 proxy";
    longDescription = ''
      Shadowsocks-libev is a lightweight secured SOCKS5 proxy for embedded devices and low-end boxes.
      It is a port of Shadowsocks created by @clowwindy, which is maintained by @madeye and @linusyang.
    '';
    homepage = https://github.com/shadowsocks/shadowsocks-libev;
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.nfjinjing ];
    platforms = platforms.all;
  };
}
