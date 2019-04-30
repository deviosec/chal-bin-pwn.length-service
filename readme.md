# Challenge - Length Service
This functions as a basic example, of how to create a remote binary challenge for OCTP.
For a basic tutorial of how Docker challenges work, take a look at the Hello World intro challenge at [https://github.com/deviosec/chal-web.helloworld](https://github.com/deviosec/chal-web.helloworld).

This challenge uses inetd combined with a simple Nginx server.
The important aspects of this challenge, is in `src/init.sh`, `src/etc/inetd.conf` and `src/etc/services`.
It should be fairly self explanatory, but please file a issue for any questions.
