##Introduction
A walk-through of setting up an application cookbook and environment *before* writing application code.

## Requirements
* vagrant
* virtualbox
* vagrant-berkshelf plugin

## Blog outline
1. Jenkins VM in Vagrant file
2. App VM
3. recipes/ci.rb containing ci job (git plugin), "blank" job on jenkins
4. recipes/build_tools.rb (git, grails)
5. create grails app and recipes/ci.rb - proper grails build (archive artefact) 
6. recipes/deploy.rb - tomcat and deploy from jenkins - check works in app VM
7. write some application code - unit test - new entity
8. integration test
9. configure proper DB (postgresql) - add to build_tools.rb and app.rb

Done!
