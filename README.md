# NFS Ganesha
A user mode nfs server implemented in a container. Supports serving NFS (v3, 4.0, 4.1, 4.1 pNFS, 4.2) and 9P.

This container uses ephemeral in-memory storage (nfs-ganesha-mem) and is intended for tests and experiments only.

### Versions
* nfs-ganesha: 2.6.0
* nfs-ganesha-mem: 2.6.0

### Environment Variables
* `GANESHA_LOGFILE`: log file location
* `GANESHA_CONFIGFILE`: location of ganesha.conf
* `GANESHA_OPTIONS`: command line options to pass to ganesha
* `GANESHA_EPOCH`: ganesha epoch value
* `GANESHA_EXPORT_ID`: ganesha unique export id
* `GANESHA_EXPORT`: export location
* `GANESHA_ACCESS`: export access acl list
* `GANESHA_ROOT_ACCESS`: export root access acl list
* `GANESHA_NFS_PROTOCOLS`: nfs protocols to support
* `GANESHA_TRANSPORTS`: nfs transports to support
* `GANESHA_BOOTSTRAP_CONFIG`: write fresh config file on start
* `GANESHA_GRACELESS`: disable the NFSv4 grace period (**true** by default)
* `STARTUP_SCRIPT`: location of a shell script to execute on start

#### Environment Placement in Config File
````
EXPORT
{
		# Export Id (mandatory, each EXPORT must have a unique Export_Id)
		Export_Id = ${GANESHA_EXPORT_ID};

		# Exported path (mandatory)
		Path = ${GANESHA_EXPORT};

		# Pseudo Path (for NFS v4)
		Pseudo = ${GANESHA_PSEUDO_PATH};

		# Access control options
		Access_Type = RW;

		# Exporting FSAL
		FSAL {
			Name = MEM;
		}
}
````

### Usage
```bash
docker run -d --name nfsd vasilev/nfs-ganesha
```

### Credits
* [apnar/docker-image-nfs-ganesha](https://github.com/apnar/docker-image-nfs-ganesha)
* [janeczku/docker-nfs-ganesha](https://github.com/janeczku/docker-nfs-ganesha)
