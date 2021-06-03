SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [stg].[sp_lty_cliente]
AS
  /***************************************************************************************************
  Procedure:          stg.sp_lty_cliente
  Create Date:        20210523
  Author:             dÁlvarez
  Description:        carga las tablas de BIBOCL
  Call by:            none
  Affected table(s):  stg.LYTY_CLI
  Used By:            BI
  Parameter(s):       none
  Log:                none
  Prerequisites:      none
  ****************************************************************************************************
  SUMMARY OF CHANGES
  Date(YYYYMMDD)      Author              Comments
  ------------------- ------------------- ------------------------------------------------------------
  20210523            dÁlvarez            creación
  
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
  DECLARE @sqlCommand VARCHAR(5000)

  SET DATEFIRST 1;

  SET @strgFec = CONVERT(VARCHAR, GETDATE(), 112);
  SET @strgTim = REPLACE(CONVERT(VARCHAR, GETDATE(), 108), ':', '');
  --SET @strgFec = '20219988';
  --SET @strgTim = '242322';
  SET @strgFT = CONCAT(@strgFec, @strgTim);

  SET @prceso = 'CARGATABLA';
  SET @objtnm = 'stg.LYTY_CLI';
  --SET @s_fld1 = 'azure';

  TRUNCATE TABLE stg.LYTY_CLI;

  INSERT INTO stg.LYTY_CLI
  SELECT *
    FROM [10.100.150.25].BICLBO.bds.CLIENTES;

GO