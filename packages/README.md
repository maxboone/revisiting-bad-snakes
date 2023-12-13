# Sources

In this folder you find the root of all evil - malicious packages and other dangerous shenanigans.

You can download and extract the repositories using the scripts, only run them from THIS folder as CWD / PWD
as it WILL download files and extract them from this position.

You can find scripts for each dataset, look out that the random & top collection from PyPI scripts are not
determined at this time and will change on each run.

## Scripts

For each dataset source you will find a folder in the `./scripts` folder - with two separate scripts: `download.sh` and `annotate.sh`.
The first will download the packages and the second will annotate based on the download result which packages and which versions we just
downloaded.

Such that:

```bash
./scripts/datadog/download.sh
```

Will leave you with packages to scan (do note, these might be encrypted at rest for safety, at least they are for datadog) and a file
in the `dataset` folder on what goods you just received. 

### Password-protected datasets

Note that both Backstabbers and MalOSS are password-protected datasets, we'll try to pull these over https, so you can log in using a
personal access token from GitHub.
