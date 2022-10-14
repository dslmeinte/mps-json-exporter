TMP_PATH=tmp
rm -rf $TMP_PATH
mkdir $TMP_PATH

MPS_PROJECT_PATH=$TMP_PATH/mpsProject
mkdir -p $MPS_PROJECT_PATH
npx degit https://github.com/dslmeinte/mps-open-source/mps-open-source $MPS_PROJECT_PATH
# NOTE: If the degit command fails with "! zlib: unexpected end of file", then try deleting the ~/.degit directory entirely!

LANGUAGES_PATH=$MPS_PROJECT_PATH/languages
GEN_PATH=src-gen
rm $GEN_PATH/*

function runCli {
  deno run --allow-read --allow-write src/languageStructure/cli.ts "$LANGUAGES_PATH/$1" $GEN_PATH
}

runCli "Json"
runCli "JsonSchema"

# this should do exactly the same as the previous two statements, except that debug info is written to tmp/:
deno run --allow-read --allow-write src-test/languageStructure/test.ts

deno run --allow-read --allow-write src-test/jsonSchema/test.ts
./src-test/jsonSchema/diff-jsonSchemas-examples.sh

