#!/usr/bin/env python
# coding: utf-8

# Importanto as bibliotecas necessárias para o script
import requests
import zipfile
import warnings
import boto3

#URL do INEP com os dados dos exames ENEM particionados por ANO
url = 'https://download.inep.gov.br/microdados/'
prefix = 'microdados_enem_'
ano = '2020'
extension = 'zip'
local_download = 'C:/Users/Barros/Downloads/'
#Montando as variáveis para download
arquivo = prefix+ano+'.'+extension
url_download = url+arquivo


# URL qual sera feito o downloads
response = requests.get(url_download)
open(local_download+arquivo,"wb").write(response.content)

# Extraindo o arquivo zip para uma pasta local
file = local_download+arquivo
path = local_download+'/zips'
with zipfile.ZipFile(file, 'r') as zip_ref:
    zip_ref.extractall(path)

# FAZENDO O UPLOAD DO ARQUIVO LOCAL PARA BUCKET S3
caminho_arquivo_local = path+'/DADOS/MICRODADOS_ENEM_2020.csv'
nome_arquivo_upload = 'MICRODADOS_ENEM_2020.csv' 
bucket = 'datalake-arthurbarros-estudos'
folder = 'enem/raw-data/'
ACCESS_KEY='<SUA_ACCESS_KEY>',
ACCESS_SECRET='SUA_SECRET_KEY'
REGION = 'us-east-2'
#s3 = boto3.client('s3')
s3_client = boto3.client('s3', region_name=REGION, aws_access_key_id=ACCESS_KEY,
                               aws_secret_access_key=ACCESS_SECRET)
with open(caminho_arquivo_local, 'rb') as f: 
        s3.upload_fileobj(f, bucket, folder+nome_arquivo_upload)
        
#criando um bloquinho de mensagem ao concluir o job
response = result.get('ResponseMetadata')

if response.get('HTTPStatusCode') == 200:
    print('File Uploaded Successfully')
else:
    print('File Not Uploaded')