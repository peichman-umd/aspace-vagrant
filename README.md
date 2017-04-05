# aspace-vagrant

UMD Libraries' ArchivesSpace Vagrant

## Quick Start

```bash
git clone git@github.com:umd-lib/aspace-vagrant.git
cd aspace-vagrant
vagrant up
```

* Admin interface: <http://192.168.40.100:8080/>
  * username: admin
  * password: admin 
* Public interface: <http://192.168.40.100:8081/>
* Solr: <http://192.168.40.100:8090/>
* REST API: <http://192.168.40.100:8089/>

Because the startup time for ArchivesSpace can be lengthy, you may need to wait a minute or two for all of these endpoints to come up.

## Starting ArchivesSpace

The ArchivesSpace application is started as part of the provisioning process. In case you need to manually start it (for example, after running a `vagrant reload`), do the following:

```bash
vagrant ssh
cd /apps/aspace/aspace
./control start
```

## License
 
See the [LICENSE](LICENSE.md) file for license rights and limitations (Apache 2.0).
