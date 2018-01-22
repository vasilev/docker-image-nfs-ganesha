# NFS Ganesha
A user mode nfs server implemented in a container. Supports serving NFS (v3, 4.0, 4.1, 4.1 pNFS, 4.2) and 9P. This container should also be configurable with all of the nfs-ganesha supported FSAL backends.

Currently generates a config for just serving a local path over nfs. However supplying `GANESHA_CONFIGFILE` would allow ganesha to be pointed to a bind mounted config file for other FASLs/more advanced configuration.

### Versions
* ganesha: 2.4
* glusterfs-common: 3.11

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
		Pseudo = /;

		# Access control options
		Access_Type = RW;
		Squash = No_Root_Squash;
		Root_Access = "${GANESHA_ROOT_ACCESS}";
		Access = "${GANESHA_ACCESS}";

		# NFS protocol options
		Transports = "${GANESHA_TRANSPORTS}";
		Protocols = "${GANESHA_NFS_PROTOCOLS}";

		SecType = "sys";

		# Exporting FSAL
		FSAL {
			Name = VFS;
		}
}
````

### Usage
```bash
docker run -d \
--name nfs \
-v /local/export/path:/export \
mitcdh/nfs-ganesha \
```

### Credits
* [janeczku/docker-nfs-ganesha](https://github.com/janeczku/docker-nfs-ganesha)
