rm -r tests/output
mkdir -p tests/output

echo MIX_PROCESS_ENV: "$MIX_PROCESS_ENV" >> tests/output/test.txt
echo MIX_DOT_ENV: "$MIX_DOT_ENV" >> tests/output/test.txt
echo MIX_NO_INPUT: "$MIX_NO_INPUT" >> tests/output/test.txt
echo GENERIC_ENV: "$GENERIC_ENV" >> tests/output/test.txt
echo MIX_BYPASS_ENV: "$MIX_BYPASS_ENV" >> tests/output/test.txt
echo PUBLIC_URL: "$PUBLIC_URL" >> tests/output/test.txt

echo MIX_INJECT_ENV1: "$MIX_INJECT_ENV1" >> tests/output/test2.txt
echo MIX_INJECT_ENV2: "$MIX_INJECT_ENV2" >> tests/output/test2.txt
echo PUBLIC_URL: "$PUBLIC_URL" >> tests/output/test2.txt

mkdir -p tests/output/test3
echo MIX_INJECT_ENV3: "$MIX_INJECT_ENV3" >> tests/output/test3/test3.txt
echo MIX_INJECT_ENV3: "$MIX_INJECT_ENV3" >> tests/output/test3/test3b.txt

echo MIX_INJECT_ENV4: "$MIX_INJECT_ENV4" >> tests/output/test4.txt



