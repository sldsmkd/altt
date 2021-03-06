# altt

## Key Directories & Files

* site/ - the artifacts for the website
* roles/ - chef definitions for differing roles
* cookbooks/altt - wrapper cookbook with configuration overrides
* Vagrantfile - for provisioning

## Usage

* vagrant up
* connect to Load Balancer at http://localhost:8000/
* Edit Vagrantfile if there are network clashes, config is in an array at the start

## Requirements

* Create a Vagrantfile that creates a single machine using this box:https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-64-nocm and installs the latest released version of your chosen configuration management tool.

__Done, learning experience here in that Vagrant manages the installation of the Config Management. Selected Chef-Zero as it emulates the behaviour of a full Chef Install without the Server.__

__The dependency tree was sorted out by using Berkshelf, it's pulled in some extra cookbooks that we don't use but that is fine.__

* Install the nginx webserver via configuration management.

__This is pretty easy, I prefer to use the wrapper/decorator pattern with upstream Chef cookbooks as they are either completely unmaintained and dont accept pull requests or are very up to date and we don't want to miss out on new features. Either way, it's better not to fork upstream when you can monkey patch with chef-rewind. Put a simple HTML5 template page in.__

* Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80

__Simple python script, checks URL multiple times, and counts varying responses, returns number of servers in service__

* Again, using configuration management, update contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admin group can sudo with a password.

__sudo cookbook covered that, I moved the config out to roles at this point, taking advantage of Chef Zero.__

* Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made

__Chef usually manages this okay, by sending notifications to the service to reload and setting that to delayed.__

* Create a simple "Hello World" web application in your favourite language of choice.

__Quick Python / WSGI script, extends the simple HTML created earlier and injects the server hostname.__

* Ensure your web application is available via the nginx instance.

__Added an application recipe that install supervisord to lifecycle manage uwsgi and got it listening on a unix domain socket. Nginx was configured to proxy onto it.__

* Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.

__Config was defined upfront in an Array, then iterators were used to provision each instance.__

* Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.

__Ideally I'd tool something here with Test Kitchen and ServerSpec, but didn't have enough time. Python script used instead__

