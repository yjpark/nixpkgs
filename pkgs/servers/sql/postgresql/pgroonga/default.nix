{ stdenv, fetchurl, pkgconfig, postgresql, libmsgpack, groonga }:

stdenv.mkDerivation rec {
  name = "pgroonga-${version}";
  version = "2.0.5";

  src = fetchurl {
    url = "http://packages.groonga.org/source/pgroonga/${name}.tar.gz";
    sha256 = "1c4m1rg3122y8rndgz7sj9a49l3v9nm0qbpa04pls20pxzx21g5a";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ postgresql libmsgpack groonga ];

  makeFlags = [ "HAVE_MSGPACK=1" ];

  installPhase = ''
    mkdir -p $out/bin
    install -D pgroonga.so -t $out/lib/
    install -D ./{pgroonga-*.sql,pgroonga.control} -t $out/share/extension
  '';

  meta = with stdenv.lib; {
    description = "A PostgreSQL extension to use Groonga as the index";
    longDescription = "PGroonga is a PostgreSQL extension to use Groonga as the index. PostgreSQL supports full text search against languages that use only alphabet and digit. It means that PostgreSQL doesn't support full text search against Japanese, Chinese and so on. You can use super fast full text search feature against all languages by installing PGroonga into your PostgreSQL.";
    homepage = https://pgroonga.github.io/;
    license = licenses.postgresql;
    maintainers = with maintainers; [ DerTim1 ];
  };
}
