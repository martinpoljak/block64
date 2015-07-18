block64
=======

**Block64** is a replacement for original [crypto64][3] gem. It can encrypt
and decrypt data of arbitrary length by [RSA][4] public/private key. It's
fixed for *use with latest Ruby* and *much faster* than original.

### Usage

API is trivial and usage is simple:

    require "block64"

    key = OpenSSL::PKey::RSA::new(<pem-encoded-key>)
    encoded = key.encrypt64(<some-very-long-message>)
    decoded = key.decrypt64(encoded)


Copyright
---------

Copyright &copy; 2007 Bart Teeuwisse and &copy; 2010 &ndash; 2015 [Martin Poljak][2].
See `LICENSE.txt` for further details.

[1]: http://github.com/martinkozak/block64/issues
[2]: http://www.martinpoljak.net/
[3]: http://github.com/bartt/crypto64
[4]: http://en.wikipedia.org/wiki/RSA
