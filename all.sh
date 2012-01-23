#/usr/bin/env bash
scripts=( sync clean build package )
for script in ${scripts[@]}; do
	$(dirname "${0}")/$script.sh
done