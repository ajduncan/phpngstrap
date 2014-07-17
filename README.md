# phpngstrap #

Pretty straight forward build of phpng under Ubuntu 14.04 inside a Vagrant box.

## Running ##

Just issue:

	$ vagrant up

## Notes ##

* I haven't had time to test or fine tune the build, I may try to create a docker container for this if there isn't already one.

* Some of the dependencies might be better built from source instead of older packages.

## Todo ##

* Hook in /vagrant/run.php if it exists using an nginx/fastcgi/phpng setup?
