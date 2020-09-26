# Librerias
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

glueContext = GlueContext(SparkContext.getOrCreate())

# catalog: bases de datos y sus nombres
db_name = "demodb-richie"
tbl_persons = "persons_json"
tbl_membership = "memberships_json"
tbl_organization = "organizations_json"

# Directorios de salida enS3
output_history_dir = "s3://demo-redshift-richie/data-final/legislator_history"

# Creación de los Dynamic Frames de las tablas de origen
persons = glueContext.create_dynamic_frame.from_catalog(database=db_name, table_name=tbl_persons)
memberships = glueContext.create_dynamic_frame.from_catalog(database=db_name, table_name=tbl_membership)
orgs = glueContext.create_dynamic_frame.from_catalog(database=db_name, table_name=tbl_organization)

# Mantenemos unos campos y se renombran otros
orgs = orgs.drop_fields(['other_names', 'identifiers']).rename_field('id', 'org_id').rename_field('name', 'org_name')

# Union de los frames para crear una historia
l_history = Join.apply(orgs, Join.apply(persons, memberships, 'id', 'person_id'), 'org_id', 'organization_id').drop_fields(['person_id', 'org_id'])
l_history.printSchema()

# ---- Escribiendo la salida de la historia ----

# escribiendo el dynamic frame en formato parquet en el directorio "legislator_history" 
glueContext.write_dynamic_frame.from_options(frame = l_history, connection_type = "s3", connection_options = {"path": output_history_dir}, format = "parquet")
#l_history.printSchema()

dfc = l_history.relationalize("hist_root", "s3://demo-redshift-richie/temp-dir/")
dfc.keys()

l_history.select_fields('contact_details').printSchema()
dfc.select('hist_root_contact_details').toDF().where("id = 10 or id = 75").orderBy(['id','index']).show()

dfc.select('hist_root').toDF().where("contact_details = 10 or contact_details = 75").select(['id', 'given_name', 'family_name', 'contact_details']).show()

for df_name in dfc.keys():
    m_df = dfc.select(df_name)
    #print "Writing to Redshift table: ", df_name
    glueContext.write_dynamic_frame.from_jdbc_conf(frame = m_df,
                                                   catalog_connection = "conexion-demo-redshift-richie",
                                                   connection_options = {"dbtable": df_name, "database": "db-richie"},
                                                   redshift_tmp_dir = "s3://demo-redshift-richie/temp-dir/")