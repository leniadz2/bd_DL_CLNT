SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [ods].[sp_srv_carga_v1] @prceso NVARCHAR(50), @objtnm NVARCHAR(50), @strgFT NVARCHAR(14), @s_fld1 NVARCHAR(50), @s_fld2 NVARCHAR(14), @strgTim NVARCHAR(6)
AS
/***************************************************************************************************
Procedure:          [ods].[sp_srv_carga]
Create Date:        20210524
Author:             dÁlvarez
Description:        tbd
Call by:            none
Affected table(s):  ods.SRV_TABLON
Used By:            BI
Parameter(s):       tbd
Log:                ctl.CONTROL
Prerequisites:      [stg].[sp_srv_carga*]
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210524            dÁlvarez            creación

***************************************************************************************************/

  DECLARE @i_fld1 INT;

  SET DATEFIRST 1;

  TRUNCATE TABLE ods.SRV_TABLON;

  INSERT INTO ods.SRV_TABLON
  SELECT IIF(ID                     ='',NULL,ID                     )
        ,IIF(NOMBRE                 ='',NULL,UPPER(NOMBRE)          )
        ,IIF(RAZONSOCIAL            ='',NULL,UPPER(RAZONSOCIAL)     )
        ,IIF(NOMBRETIENDA           ='',NULL,UPPER(NOMBRETIENDA)    )
        ,IIF(CODIGOMALL             ='',NULL,RIGHT(CONCAT('00',CODIGOMALL),2)             )
        ,IIF(CODIGOTIENDA           ='',NULL,RIGHT(CONCAT('0000',CODIGOTIENDA),4)         )
        ,IIF(RUCEMISOR              ='',NULL,RUCEMISOR              )
        ,IIF(IDENTIFICADORTERMINAL  ='',NULL,IDENTIFICADORTERMINAL  )
        ,IIF(NUMEROTERMINAL         ='',NULL,NUMEROTERMINAL         )
        ,IIF(SERIE                  ='',NULL,SERIE                  )
        ,IIF(TIPOTRANSACCION        ='',NULL,RIGHT(CONCAT('00',TIPOTRANSACCION),2)        )
        ,IIF(NUMEROTRANSACCION      ='',NULL,NUMEROTRANSACCION      )
        ,IIF(FECHA                  ='',NULL,LEFT(FECHA,10)         )
        ,IIF(HORA                   ='',NULL,HORA                   )
        ,IIF(CAJERO                 ='',NULL,CAJERO                 )
        ,IIF(VENDEDOR               ='',NULL,VENDEDOR               )
        ,IIF(DNI                    ='',NULL,DNI                    )
        ,IIF(RUC                    ='',NULL,RUC                    )
        ,IIF(NOMBRECLIENTE          ='',NULL,UPPER(NOMBRECLIENTE)   )
        ,IIF(DIRECCIONCLIENTE       ='',NULL,UPPER(DIRECCIONCLIENTE))
        ,IIF(BONUS ='-',NULL,IIF(BONUS ='',NULL,BONUS))
        ,IIF(MONEDA                 ='',NULL,MONEDA                 )
        ,IIF(MEDIOPAGO              ='',NULL,MEDIOPAGO              )
        ,TOTALVALORVENTABRUTA
        ,DESCUENTOSGLOBAL
        ,MONTOTOTALIGV
        ,TOTALVALORVENTANETA
        ,IIF(ORDENITEM              ='',NULL,ORDENITEM              )
        ,CANTIDADUNIDADESITEM
        ,IIF(CODIGOPRODUCTO         ='',NULL,CODIGOPRODUCTO         )
        ,IIF(DESCRIPCIONPRODUCTO    ='',NULL,UPPER(DESCRIPCIONPRODUCTO))
        ,PRECIOVENTAUNITARIOITEM
        ,CARGODESCUENTOITEM
        ,PRECIOTOTALITEM
        ,@strgFT
   FROM stg.SRV_TABLON;

  INSERT INTO ods.H_SRV_TABLON
  SELECT *, @s_fld1
    FROM ods.SRV_TABLON;

  SELECT @i_fld1 = COUNT(*) FROM ods.SRV_TABLON;

  UPDATE ctl.CONTROL
    SET S_FLD9 = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', ''),
        I_FLD1 = @i_fld1
  WHERE PRCESO = @prceso
    AND OBJTNM = @objtnm
    AND FECHOR = @strgFT
    AND S_FLD1 = @s_fld1;

TRUNCATE TABLE ods.SRV_TABLON_tmp_v1;

  INSERT INTO ods.SRV_TABLON_tmp_v1
  SELECT st.*
    FROM bds.SRV_TABLON_v1 st

TRUNCATE TABLE ods.SRV_TABLON_dlt;

  INSERT INTO ods.SRV_TABLON_dlt
  SELECT t.*
    FROM (SELECT st.ID
                ,st.ORDENITEM
            FROM ods.SRV_TABLON_tmp_v1 st
          EXCEPT
          SELECT st.ID
                ,st.ORDENITEM
            FROM ods.SRV_TABLON st) AS t;

GO