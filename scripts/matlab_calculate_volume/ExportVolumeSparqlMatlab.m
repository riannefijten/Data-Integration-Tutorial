function ExportVolumeSparqlMatlab( endpointUrl, rtStructUid, structLabel, volume, version, dateTimeString )

%load query
query = fileread('insertQuery.sparql');

query = strrep(query, '##STRUCTUID##', rtStructUid);
query = strrep(query, '##LABEL##', structLabel);
query = strrep(query, '##VOLUME##', num2str(volume));
query = strrep(query, '##VERSION##', version);
query = strrep(query, '##DATETIME##', dateTimeString);

[colNames, resultSet, extra] = sparql(endpointUrl, query, 'yes');

end

