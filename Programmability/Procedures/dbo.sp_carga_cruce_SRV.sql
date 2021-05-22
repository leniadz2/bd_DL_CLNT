SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_carga_cruce_SRV]
AS
BEGIN

  --declare @fechaD date;
  --declare @fechaS nvarchar(8);

  DECLARE @strgfini NVARCHAR(8);
  DECLARE @strgffin NVARCHAR(8);
  DECLARE @datefini DATE;
  DECLARE @dateffin DATE;

  SET DATEFIRST 1;

  SET @strgfini = '20210501';
  --SET @strgffin = '20210502';

  SET @datefini = CONVERT(DATE, CONCAT(SUBSTRING(@strgfini, 1, 4), '-', SUBSTRING(@strgfini, 5, 2), '-', SUBSTRING(@strgfini, 7, 2)));
  --SET @dateffin = CONVERT(DATE, CONCAT(SUBSTRING(@strgffin, 1, 4), '-', SUBSTRING(@strgffin, 5, 2), '-', SUBSTRING(@strgffin, 7, 2)));

  DROP TABLE ods.t_cruce_srv_vista_1;
  DROP TABLE ods.t_cruce_srv_vista_2;
  DROP TABLE ods.t_cruce_srv_vista_3;

  SELECT
    CONCAT(SUBSTRING(fecha, 1, 4), SUBSTRING(fecha, 6, 2), SUBSTRING(fecha, 9, 2)) AS FECHA
   ,CASE
      WHEN CODIGOMALL = '01' THEN '3001CC'
      WHEN CODIGOMALL = '02' THEN '4007CC'
    END AS UE
   ,RUCEMISOR AS RUC
   ,SupPartyRegName AS RAZON_SOCIAL
   ,SupPartyName AS NOMBRE_COMERCIAL
   ,MONEDA
   ,CONVERT(FLOAT, TOTALVALORVENTANETA) AS MONTO
   ,ID
   ,ORDEN INTO ods.t_cruce_srv_vista_1
  FROM bd_srv.dwh.cew_data
  --WHERE fecha >= @datefini
  ;

  SELECT
    FECHA
   ,UE
   ,RUC
   ,RAZON_SOCIAL
   ,NOMBRE_COMERCIAL
   ,MONEDA
   ,ID
   ,MAX(MONTO) AS MONTO INTO ods.t_cruce_srv_vista_2
  FROM ods.t_cruce_srv_vista_1
  GROUP BY FECHA
          ,UE
          ,RUC
          ,RAZON_SOCIAL
          ,NOMBRE_COMERCIAL
          ,MONEDA
          ,ID
  ORDER BY FECHA, UE, RUC, RAZON_SOCIAL, NOMBRE_COMERCIAL, MONEDA, ID;

  SELECT
    FECHA
   ,UE
   ,RUC
   ,RAZON_SOCIAL
   ,NOMBRE_COMERCIAL
   ,MONEDA
   ,SUM(MONTO) AS MONTO
   ,COUNT(ID) AS TRX INTO ods.t_cruce_srv_vista_3
  FROM ods.t_cruce_srv_vista_2
  GROUP BY FECHA
          ,UE
          ,RUC
          ,RAZON_SOCIAL
          ,NOMBRE_COMERCIAL
          ,MONEDA
  ORDER BY FECHA, UE, RUC, RAZON_SOCIAL, NOMBRE_COMERCIAL, MONEDA;


END
GO