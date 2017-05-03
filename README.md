# aspace-vagrant

UMD Libraries' ArchivesSpace Vagrant

## Prerequisites

* VirtualBox
* [Oracle Java 8 JDK][jdk] (download and place in [dist](dist))
* A Solr base box built from [solr-vagrant-base]:
  
  ```bash
  cd /apps/git
  git clone git@github.com:umd-lib/solr-vagrant-base.git
  cd solr-vagrant-base
  vagrant up
  vagrant package --output solr.box
```

* An [archivesspace-core] Solr core at `/apps/git/archivesspace-core`:
  
  ```bash
  cd /apps/git
  git clone git@bitbucket.org:umd-lib/archivesspace-core.git
  ```
  
* An [aspace-env] runtime environment at `/apps/git/aspace-env`:

  ```bash
  cd /apps/git
  git clone git@bitbucket.org:umd-lib/aspace-env.git
  ```
  
* Add the following lines to your host's `/etc/hosts` file, so Apache can do the proper hostname-based routing to the public and staff interfaces:

  ```
  192.168.40.100 aspacelocal
  192.168.40.102 archiveslocal
  ```

## Quick Start

```bash
cd /apps/git
git clone git@github.com:umd-lib/aspace-vagrant.git
cd aspace-vagrant
cp ../solr-vagrant-base/solr.box dist
vagrant up
```

* Admin interface: <https://aspacelocal/>
  * username: admin
  * password: admin 
* Public interface: <https://archiveslocal/>

Because the startup time for ArchivesSpace can be lengthy, you may need to wait a minute or two for all of these endpoints to come up.

Solr will be running on its own VM, separate from the ArchivesSpace VM:

* Solr: <http://192.168.40.101:8984/>

## Starting ArchivesSpace and Solr

The ArchivesSpace and Solr applications are started as part of the provisioning process. In case you need to manually start them (for example, after running a `vagrant reload`), do the following:

```bash
# ArchivesSpace
vagrant ssh aspace
cd /apps/aspace/aspace
./control start
```

```bash
# Solr
vagrant ssh solr
cd /apps/solr/solr
./control startnossl
```

## License
 
See the [LICENSE](LICENSE.md) file for license rights and limitations (Apache 2.0).

[jdk]: http://www.oracle.com/technetwork/java/javase/downloads/index-jsp-138363.html
[solr-vagrant-base]: https://github.com/umd-lib/solr-vagrant-base
[archivesspace-core]: https://bitbucket.org/umd-lib/archivesspace-core
[aspace-env]: https://bitbucket.org/umd-lib/aspace-env
