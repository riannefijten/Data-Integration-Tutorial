SET "CURRENTDIR=%~dp0"

cd "C:\tmp\d2rq-0.8.1"
CALL dump-rdf -b http://SP4-JOHAN.ad.maastro.nl/rdf/ -o "%CURRENTDIR%\output.ttl" "%CURRENTDIR%\registry_mapping.ttl"

cd %CURRENTDIR%
curl -X POST http://localhost:9999/blazegraph/sparql --data-urlencode "update=DROP ALL"
curl -X POST http://localhost:9999/blazegraph/sparql --data-urlencode "update=LOAD <file:///C:/tmp/d2r/output.ttl>;"