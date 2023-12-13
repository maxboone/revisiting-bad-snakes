if [ "$#" -ne 2 ]; then
    echo The cli arguments should be:
		echo ./bandit4mal.sh [directory with packages] [name of output file]
    echo Example use:
    echo ./bandit4mal.sh packages output.txt
		exit 1
fi

DIR=$1
OUTPUT_FILE=$2


PACKAGE_NAMES=$(find $DIR -mindepth 1 -maxdepth 1 -type d -printf '%f\n')

echo "{" > $OUTPUT_FILE && parallel --tag-string="\"{}\":" --group "bandit -r $DIR/{} --f json 2> /dev/null | tr '\n' ' ' && echo "," " ::: $PACKAGE_NAMES >> $OUTPUT_FILE 
sed -i '$ s/.$//' $OUTPUT_FILE
echo "}" >> $OUTPUT_FILE
