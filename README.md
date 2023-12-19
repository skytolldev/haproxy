# Description
Image based on official Alpine Linux image with ``haproxy`` and ``bash`` installed via apk.
Entrypoint is ``entrypoint.bash`` BASH script executing following actions:
* check if there is any configuration file in ``/usr/local/etc/haproxy/conf.d`` (exit with error if there is none)
* launch ``haproxy`` with following parameters:
  * ``-f /usr/local/etc/haproxy/haproxy.cfg`` - basic configuration
  * ``-f /usr/local/etc/haproxy/conf.d`` - directory with configuration files
  * ``-db`` - disable background mode
  * ``-W`` - master-worker mode

## Configuration
Custom basic configuration file provided as parameter to ``haproxy`` sets only
``stats``, ``log`` directives and then includes configuration
files present in directory ``/usr/local/etc/haproxy/conf.d``.
This directory is volume and it should be mount in Read-Only mode.

With above in mind it's obvious that all configuration is expected to be provided
by included configuration files. That's why entrypoint script fails with error
when there are none.

## Volumes
There is one volume by default for configuration files:
* ``/usr/local/etc/haproxy/conf.d``
