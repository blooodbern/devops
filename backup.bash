#!/bin/bash
while getopts i:o: flag
do
	case "${flag}" in
		i) inputDir=${OPTARG};;
		o) outputDir=${OPTARG};;
	esac
done

if [[ "$inputDir" == *".."* ]]
then
	echo "Don't use '..' in input."
	exit 1
fi

if [ ! -d "$inputDir" ] || [ ! -d "$outputDir" ]
then
	echo "Input or output directory doesn't exist."
	exit 1
fi

if ! command -v zip &> /dev/null
then
	echo "Zip isn't installed. Installing zip..."
	sudo apt install zip unzip
fi

if [ -z "$inputDir" ] || [ -z "$outputDir" ]
then
	echo "Input or output directory not set. Use -i and -o to set them."
	exit 1
fi

outputFilename="$outputDir/$(basename "$inputDir")-$(date +"%Y-%m-%d_%H:%M:%S").zip"

echo "Backing up $inputDir to $outputFilename"

zip -r "$outputFilename" "$inputDir"
