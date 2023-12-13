PACKAGES=$(find packages/download/dependents/ -type f -name '*.tar.gz')
COMMANDS=""

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for file in $PACKAGES; do
    package_name=$(basename "$file")
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-ossgadget oss-detect-backdoor /tmp/package/*/setup.py > \"./bench/dependents/$package_name-ossgadget.out-setup\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-bandit4mal bandit -r /tmp/package/*/setup.py > \"./bench/dependents/$package_name-bandit4mal.out-setup\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-pypi /app/pypi.py /tmp/package/*/setup.py > \"./bench/dependents/$package_name-pypi.out-setup\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-ossgadget oss-detect-backdoor /tmp/package > \"./bench/dependents/$package_name-ossgadget.out-full\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-bandit4mal bandit -r /tmp/package > \"./bench/dependents/$package_name-bandit4mal.out-full\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-pypi /app/pypi.py /tmp/package > \"./bench/dependents/$package_name-pypi.out-full\"\n"
    COMMANDS+="docker run --memory=4g --rm -v \"./$file:/tmp/package.tar.gz:ro\" secproj-guarddog guarddog pypi scan /tmp/package > \"./bench/dependents/$package_name-guarddog.out-full\"\n"
done
IFS=$SAVEIFS

echo -e $COMMANDS > ./bench/dependents.batch