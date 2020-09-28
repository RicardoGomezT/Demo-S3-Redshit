# ETL en Aws GLUE: Json semiestructurados de S3 a REDSHIFT

Con Redshift se puede consultar grandes volúmenes de información en el orden inclusive de los petabytes de datos estructurados y no estructurados, nos permite también explorar diferentes fuentes de información asi como guardar resultados de consultas SQL o mediante ETLs en un lago de datos de S3 para posteriores análisis, sin duda son muchos los beneficios que generan curiosidad. En ese orden de ideas, vamos a realizar en este post para el tratamiento de información que nos entregan divididas en 3 JSON distintos y relacionados entre sí, además de tener dentro una estructura anidada con uso de arrays de tamaño indefino.

Adicional, expongo una manera diferente de hacer cargues mediante el comando COPY de Redshift. Los invito a mirar mi hilo de post donde detallo el uso de este repositorio

### Creando un Data Warehouse en REDSHIFT
https://medium.com/@ricardo.gomezt1108/creando-un-data-warehouse-en-redshift-e0784cfdc160

### Cargue de archivos de Amazon Web Service S3 a Redshift
https://medium.com/@ricardo.gomezt1108/cargue-de-archivos-de-amazon-web-service-s3-a-redshift-f9febbfbaba5

### ETL en Aws GLUE: Json semiestructurados de S3 a REDSHIFT
https://medium.com/@ricardo.gomezt1108/etl-en-aws-glue-json-semiestructurados-de-s3-a-redshift-37319931e1a1
