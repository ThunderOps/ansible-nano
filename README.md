## Ansible Role for setting up a Raiblocks Node

Sets up a Centos 7 VM from scratch as a Raiblocks node with RPC enabled. Runs locally in Docker too for dev.

Automates the steps shown here: https://github.com/clemahieu/raiblocks/wiki/Running-rai_node-as-a-service

Clone this repo and run `make` to experiment.

Once `make` has been run you can execute RPC commands against your local Docker container with:

```
curl -d '{ "action" : "version" }' localhost:7076
```

More PRC commands found here: https://github.com/clemahieu/raiblocks/wiki/RPC-protocol

Currently this playbook downloads Boost and Raiblocks from Github and builds from source so it can be quite slow when first run.

Versions can be found in `roles/raiblocks/default/main.yml`.

There is also a database task that pulls down a recent database snapshot from Google drive (approx 1GB) that speeds up the initial sync.

*Note:* You'll need to stop the Raiblocks desktop wallet (if you have that running). Or, change the port mappings in the `run:` section of the `Makefile` to non-standard ports.


## Contributing

You'll need the following dependencies:
 
- Make
- [Docker](https://store.docker.com/editions/community/docker-ce-desktop-mac)

If you're in a hurry you can run all of the below with a single command.

`make`

Otherwise it may be best to run the individual commands below to get a feel for the workflow.

Build the testing image. You should only need to do this the first time.

`make build`

Now you have an image you can start it in the background. Leave it running forever if you're lazy like me.

`make run`

You can now work on Ansible by changing the files and running.

`make config`

A typical workflow will usually involve running his over and over again while making incremental Ansible changes.

Or work on tests by running.

`make test`

Again, this can be done iteratively. You can add or change a test and run this over and over again until it passes.

The tests usually depend on the `make config` having run to completion so you may want to ensure that was run first.

To wipe the config just restart the container or run `make clean` and you're instantly back to a fresh image you can
apply `make config` to. It's generally a good idea to do this as a final test before raising a PR.

For when it all goes wrong.

`make mrproper`

This will stop and remove all container images related to this module. You'll then need to `make` to recreate 
everything.

If you want to have a poke around inside the container to debug you can use `make ssh`. Then ctrl+d to exit when 

Feel free to submit Pull Requests.
