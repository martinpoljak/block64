block64
=======

**Block64** is a replacement for original [crypto64][3] gem. It can encrypt
and decrypt arbitrary length strings by [RSA][4] public/private key. It's
fixed for *use with latest Ruby* and *much faster* than original.

### Usage

API is trivial and usage is simple:
    
    require "block64"
    
    key = OpenSSL::PKey::RSA::new(<pem-encoded-key>)
    encoded = key.encode64(<some-very-long-message>)
    decoded = key.decode64(encoded)
    

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][1] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.

Copyright
---------

Copyright (c) 2007 Bart Teeuwisse and (c) 2010 [Martin Kozák][2]. See `LICENSE.txt` for
further details.

[1]: http://github.com/martinkozak/block64/issues
[2]: http://www.martinkozak.net/
[3]: http://github.com/bartt/crypto64
[4]: http://en.wikipedia.org/wiki/RSA
