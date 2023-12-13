# Bad Snakes - Revisted

In this repository you can find the supplementary information and scripts
for the bad snakes replication study. We ran this ourselves on a hourly
rented ephemeral machine (Google Cloud 8c/32g) as the jobs can be resumed
after a graceful (30s) shutdown.

> ALL SCRIPTS SHOULD BE EXECUTED FROM THE ROOT OF THE REPO

## Prerequisites

You'll need the following applications on your machine:

- OCI Container Runtime (such as Docker)
- gVisor (runsc)
- unzip
- GNU Parallel
- jq
- sqlite3 (CLI)

These are all readily available for a popular distribution
such as `Ubuntu 22.04 LTS` which we used. Adviced specifications
for the machine are:

- x86_64 CPU with at least 8 cores
- 32 GiB RAM
- 20 GiB Disk Space

## Gathering Packages

We use 7 different sources in this research.

For malicious packges we use:

- Backstabbers **(requires access & personal access token to GitHub)**
- MalOSS **(requires access & personal access token to GitHub)**
- DataDog's Malware Package collection
- MalRegistry

For benign packages we use:

- Top 1000 Dependencies **(requires libraries.io API key)**
- Top 1000 Downloaded

For random (benign) packages we use:

- Random 1000

You can download these packages using the provided scripts:

```bash
# malicious (benign) packages
./packages/backstabbers/download.sh
./packages/datadog/download.sh
./packages/maloss/download.sh
./packages/malregistry/download.sh

# popular (benign) packages
./packages/dependents/download.sh
./packages/downloaded/download.sh

# random (benign) packages
./packages/random/download.sh
```

## Building tools

If you have an OCI runtime installed that listens to `docker`
commands (i.e. `nerdctl` for containerd, or a direct alias for
`podman`) you can build the images for the tools through shell.

Note, these tools were collected for `x86` architecture, we have
not tested them on `aarch64` architectures and don't expect them
to work on such architecture.

```bash
./oci/build.sh
```

## Scanning

Each source has a preparation step which generates a `.batch` file
that is basically just a list with all the `docker run --rm` commands
to scan a package for that source. Run the preparation script for
every source that you want to scan:

```bash
./bench/backstabbers.sh
./bench/datadog.sh
./bench/maloss.sh
./bench/malregistry.sh
./bench/dependents.sh
./bench/downloaded.sh
./bench/random.sh
```

Note, if you don't want to run a given source (because you have no
access for example), you **need** to delete the `.batch` file associated
with it. Otherwise, GNU Parallel wil fail executing the jobs.

Once generated, you can start running the `.batch` files in parallel, we
advise to do this in a virtual window such as `tmux` or `screen` so you can
revisit it later and avoid a kill on logout.

```bash
tmux # optional
./execute-bench.sh
```

## Parsing

Now that we have all the standard outputs from the tools, so we can parse
them into a central location for analysis. For this we use a SQLite3 DB.
You can prepare the SQLite DB using the sqlite3 interface.

```bash
sqlite3 ./bench.db < schema.sql
```

Then, the parsing scripts will automatically scan all packages in your bench
folder to populate this database:

```bash
./parse-results.sh
```

## Analysis

Finally, we can analyse the data. For this we used a Python Notebook, and you
should be able to run the full analysis from the just-generated `bench.db`.
