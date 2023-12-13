CREATE TABLE scanned (
    filename TEXT,
    scope TEXT,
    source TEXT,
    scanner TEXT,
    severity_low INTEGER,
    severity_medium INTEGER,
    severity_high INTEGER,
    confidence_low INTEGER,
    confidence_medium INTEGER,
    confidence_high INTEGER,
    PRIMARY KEY (filename, scope, source, scanner)
);
