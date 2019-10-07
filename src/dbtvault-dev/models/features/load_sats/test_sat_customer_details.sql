{{- config(materialized='incremental', schema='test_vlt', enabled=true, tags='feature')                 -}}

{%- set src_pk = 'CUSTOMER_PK'                                                                          -%}
{%- set src_hashdiff = 'CUSTOMER_HASHDIFF'                                                              -%}
{%- set src_payload = ['CUSTOMER_NAME', 'CUSTOMER_DOB', 'CUSTOMER_PHONE']                               -%}

{%- set src_eff = 'EFFECTIVE_FROM'                                                                      -%}
{%- set src_ldts = 'LOADDATE'                                                                           -%}
{%- set src_source = 'SOURCE'                                                                           -%}

{%- set tgt_pk = [src_pk , 'BINARY(16)', src_pk]                                                        -%}
{%- set tgt_hashdiff = [ src_hashdiff , 'BINARY(16)', 'HASHDIFF']                                       -%}
{%- set tgt_payload = [[ src_payload[0], 'VARCHAR(60)', 'NAME'],
                       [ src_payload[1], 'DATE', 'DOB'],
                       [ src_payload[2], 'VARCHAR(15)', 'PHONE']]                                       -%}

{%- set tgt_eff = ['EFFECTIVE_FROM', 'DATE', 'EFFECTIVE_FROM']                                          -%}
{%- set tgt_ldts = ['LOADDATE', 'DATE', 'LOADDATE']                                                     -%}
{%- set tgt_source = ['SOURCE', 'VARCHAR(15)', 'SOURCE']                                                -%}

{%- set source = [ref('test_stg_customer_details_hashed')]                                              -%}

{{  dbtvault.sat_template(src_pk, src_hashdiff, src_payload,
                          src_eff, src_ldts, src_source,
                          tgt_pk, tgt_hashdiff, tgt_payload,
                          tgt_eff, tgt_ldts, tgt_source,
                          source)                                                                        }}






