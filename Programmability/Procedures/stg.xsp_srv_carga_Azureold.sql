SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [stg].[xsp_srv_carga_Azureold]
AS
/***************************************************************************************************
Procedure:          stg.sp_carga_cewDataAzure
Create Date:        20210520
Author:             dÁlvarez
Description:        carga el reporte cew_data (GVillacorta) de Azure.
Call by:            none
Affected table(s):  bds.SRV_TABLON
Used By:            BI
Parameter(s):       none
Log:                ctl.CONTROL
Prerequisites:      Azure debe estar encendido (ccordinar con GVillacorta)
****************************************************************************************************
SUMMARY OF CHANGES
Date(YYYYMMDD)      Author              Comments
------------------- ------------------- ------------------------------------------------------------
20210520            dÁlvarez            creación

***************************************************************************************************/

  DECLARE @strgFec NVARCHAR(8);
  DECLARE @strgTim NVARCHAR(6);
  DECLARE @strgFT NVARCHAR(14);

  DECLARE @prceso NVARCHAR(50);
  DECLARE @objtnm NVARCHAR(50);
  DECLARE @s_fld1 NVARCHAR(50);
  DECLARE @s_fld2 NVARCHAR(14);
  DECLARE @i_fld1 INT;

  DECLARE @strgTable NVARCHAR(17);
  DECLARE @sqlCommand varchar(5000)

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  --SET @strgFec = '20219988';
  --SET @strgTim = '242322';
  SET @strgFT  = CONCAT(@strgFec,@strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'SRV_TABLON';
  SET @s_fld1 = 'azure';

  SELECT @s_fld2 = MAX(FECHOR) FROM ctl.CONTROL WHERE PRCESO = @prceso AND OBJTNM = @objtnm;

  INSERT INTO ctl.CONTROL(PRCESO, OBJTNM, FECHOR, S_FLD1, S_FLD2, S_FLD9)
  VALUES(@prceso,@objtnm,@strgFT,@s_fld1,@s_fld2 ,@strgTim);


  --SET @strgTable = CONCAT(@strgFec, '_cew_data');

  SELECT
    @strgTable = MAX(TABLE_NAME)
  FROM BD_SRV.INFORMATION_SCHEMA.TABLES
  WHERE TABLE_CATALOG = 'BD_SRV'
  AND TABLE_SCHEMA = 'tmp'
  AND TABLE_NAME LIKE '2%cew_Data';


  TRUNCATE TABLE stg.SRV_TABLON;

  SET @sqlCommand = 'INSERT INTO stg.SRV_TABLON (
  ID,
  NOMBRE,
  RAZONSOCIAL,
  NOMBRETIENDA,
  CODIGOMALL,
  CODIGOTIENDA,
  RUCEMISOR,
  IDENTIFICADORTERMINAL,
  NUMEROTERMINAL,
  SERIE,
  TIPOTRANSACCION,
  NUMEROTRANSACCION,
  FECHA,
  HORA,
  CAJERO,
  VENDEDOR,
  DNI,
  RUC,
  NOMBRECLIENTE,
  DIRECCIONCLIENTE,
  BONUS,
  MONEDA,
  MEDIOPAGO,
  TOTALVALORVENTABRUTA,
  DESCUENTOSGLOBAL,
  MONTOTOTALIGV,
  TOTALVALORVENTANETA,
  ORDENITEM,
  CANTIDADUNIDADESITEM,
  CODIGOPRODUCTO,
  DESCRIPCIONPRODUCTO,
  PRECIOVENTAUNITARIOITEM,
  CARGODESCUENTOITEM,
  PRECIOTOTALITEM)
  SELECT
      cast(cd.ID                     as varchar(30))   as c01
     ,cast(cd.SupPartyName           as varchar(50))   as c02
     ,cast(cd.SupPartyRegName        as varchar(50))   as c03
     ,cast(cd.NombreTienda           as varchar(50))   as c04
     ,cast(cd.CodigoMall             as varchar(2))    as c05
     ,cast(cd.CodigoTienda           as varchar(4))    as c06
     ,cast(cd.RucEmisor              as varchar(11))   as c07
     ,cast(cd.IdentificadorTerminal  as varchar(10))   as c08
     ,cast(cd.NumeroTerminal         as varchar(10))   as c09
     ,cast(cd.Serie                  as varchar(10))   as c10
     ,cast(cd.TipoTransaccion        as varchar(4))    as c11
     ,cast(cd.NumeroTransaccion      as varchar(10))   as c12
     ,cast(cd.Fecha                  as varchar(20))   as c13
     ,cast(cd.Hora                   as varchar(20))   as c14
     ,cast(cd.Cajero                 as varchar(20))   as c15
     ,cast(cd.Vendedor               as varchar(20))   as c16
     ,cast(cd.DNI                    as varchar(11))   as c17
     ,cast(cd.RUC                    as varchar(11))   as c18
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.CusPartyRegName as varchar(100)), ''&amp;'',''&''), CHAR(13),'';''), CHAR(10),'';''), CHAR(9),'';''), ''|'','' ''), ''"'','''') as c19
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.Direccion as varchar(200)), CHAR(13),'';''), CHAR(10),'';''), CHAR(9),'';''), ''|'','' ''), ''"'','''') as c20
     ,NULL                                             as c21
     ,cast(cd.Moneda                  as varchar(10))  as c22
     ,cast(cd.MedioPago               as varchar(10))  as c23
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.TotalValorVentaBruta))         as c24
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.CargosDescuentosGlobal))       as c25
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.MontoTotalIgv))                as c26
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.TotalValorVentaNeta))          as c27
     ,cast(cd.Orden                   as varchar(20))  as c28
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.CantidadUnidadesItem))         as c29
     ,cast(cd.CodigoProducto          as varchar(50))  as c30
     ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cast(cd.DescripcionProducto as varchar(100)), CHAR(13),'';''), CHAR(10),'';''), CHAR(9),'';''), ''|'','' ''), ''"'','''') as c31
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.PrecioVentaUnitarioItem))      as c32
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.CargoDescuentoItem))           as c33
     ,CONVERT(DECIMAL(18,2),CONVERT(float,cd.PrecioTotalItem))              as c34
    FROM [BD_SRV].tmp.['+@strgTable+'] cd';

  EXEC (@sqlCommand);

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
        ,IIF(FECHA                  ='',NULL,FECHA                  )
        ,IIF(HORA                   ='',NULL,HORA                   )
        ,IIF(CAJERO                 ='',NULL,CAJERO                 )
        ,IIF(VENDEDOR               ='',NULL,VENDEDOR               )
        ,IIF(DNI                    ='',NULL,DNI                    )
        ,IIF(RUC                    ='',NULL,RUC                    )
        ,IIF(NOMBRECLIENTE          ='',NULL,UPPER(NOMBRECLIENTE)   )
        ,IIF(DIRECCIONCLIENTE       ='',NULL,UPPER(DIRECCIONCLIENTE))
        ,IIF(BONUS                  ='',NULL,BONUS                  )
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

  TRUNCATE TABLE ods.SRV_TABLON_dlt;

  INSERT INTO ods.SRV_TABLON_dlt
  SELECT t.*
  FROM (
  SELECT st.ID
        ,st.ORDENITEM
    FROM ods.SRV_TABLON st
  EXCEPT
  SELECT hst.ID
        ,hst.ORDENITEM
    FROM ods.H_SRV_TABLON hst INNER JOIN ctl.CONTROL AS c
      ON hst.FHCARGA = c.S_FLD2
   WHERE c.FECHOR = (SELECT MAX(FECHOR) FROM ctl.CONTROL WHERE PRCESO = 'CARGATABLA' AND OBJTNM = 'SRV_TABLON')
    ) AS t;

  INSERT INTO bds.SRV_TABLON
  SELECT st.*
    FROM ods.SRV_TABLON st INNER JOIN ods.SRV_TABLON_dlt std ON st.id = std.ID AND st.ORDENITEM = std.ORDENITEM;

GO