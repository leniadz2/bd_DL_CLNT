SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROCEDURE [ods].[sp_SAP_wrk]
AS
/***************************************************************************************************
Procedure:          stg.sp_srv_cargaExcel
Create Date:        20210520
Author:             dÁlvarez
Description:        carga el reporte cew_data (GVillacorta) del excel.
Call by:            none
Affected table(s):  stg.SRV_TABLON
Used By:            BI
Parameter(s):       none
Log:                ctl.CONTROL
Prerequisites:      En caso del archivo Excel, debe importarse previamente con dbforge
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210520            dÁlvarez            creación

***************************************************************************************************/

    SELECT TRIM(scv.CODCLIENTE) AS CODCLIENTE
      ,IIF(LEN(scv.NIF)=7,CONCAT('0',scv.NIF),IIF(LEN(scv.NIF)=0,NULL,scv.NIF)) AS NIF
      ,IIF(LEN(scv.NIF)=11,'EMPRESA',IIF(LEN(scv.NIF)=0,NULL,'PERSONA')) AS TIPONIF
      ,TRIM(scv.NOMBRE) AS NOMBRE
      ,TRIM(scv.TRATAMIENTO) AS TRATAMIENTO
      ,TRIM(scv.CALLE) AS CALLE
      ,TRIM(scv.DISTRITO) AS DISTRITO
      ,TRIM(scv.CODPOSTAL) AS CODPOSTAL
      ,TRIM(scv.TELEFONO) AS TELEFONO
      ,TRIM(scv.RUBRO) AS RUBRO
      ,TRIM(scv.CLASEIMPUESTO) AS CLASEIMPUESTO
      ,0 AS VLE
    INTO ods.SAP_CLI
  FROM stg.SAP_CLI_ALL scv 




  SELECT TRIM(scv.CODCLIENTE) AS CODCLIENTE
      ,IIF(LEN(scv.NIF)=7,CONCAT('0',scv.NIF),IIF(LEN(scv.NIF)=0,NULL,scv.NIF)) AS NIF
      ,IIF(LEN(scv.NIF)=11,'EMPRESA',IIF(LEN(scv.NIF)=0,NULL,'PERSONA')) AS TIPONIF
      ,TRIM(scv.NOMBRE) AS NOMBRE
      ,TRIM(scv.TRATAMIENTO) AS TRATAMIENTO
      ,TRIM(scv.CALLE) AS CALLE
      ,TRIM(scv.DISTRITO) AS DISTRITO
      ,TRIM(scv.CODPOSTAL) AS CODPOSTAL
      ,TRIM(scv.TELEFONO) AS TELEFONO
      ,TRIM(scv.RUBRO) AS RUBRO
      ,TRIM(scv.CLASEIMPUESTO) AS CLASEIMPUESTO
      ,0 AS VLE
    INTO ods.SAP_CLI
  FROM stg.SAP_CLI_ALL scv LEFT JOIN stg.SAP_CLI_VLE scv1 
         ON  scv.CODCLIENTE = scv1.CODCLIENTE AND scv.NIF = scv1.NIF



SELECT TRIM(sca.CODCLIENTE) AS CODCLIENTE
      ,IIF(LEN(sca.NIF)=7,CONCAT('0',sca.NIF),IIF(LEN(sca.NIF)=0,NULL,sca.NIF)) AS NIF
      ,IIF(LEN(sca.NIF)=11,'EMPRESA',IIF(LEN(sca.NIF)=0,NULL,'PERSONA')) AS TIPONIF
      ,TRIM(sca.NOMBRE) AS NOMBRE
      ,TRIM(sca.TRATAMIENTO) AS TRATAMIENTO
      ,TRIM(sca.CALLE) AS CALLE
      ,TRIM(sca.DISTRITO) AS DISTRITO
      ,TRIM(sca.CODPOSTAL) AS CODPOSTAL
      ,TRIM(sca.TELEFONO) AS TELEFONO
      ,TRIM(sca.RUBRO) AS RUBRO
      ,TRIM(sca.CLASEIMPUESTO) AS CLASEIMPUESTO
      ,TRIM(scv.NIF) AS NIFSCV
  INTO ods.SAP_CLI
  FROM stg.SAP_CLI_ALL sca LEFT JOIN stg.SAP_CLI_VLE scv 
       ON sca.CODCLIENTE = scv.CODCLIENTE AND sca.NIF = scv.NIF;
GO