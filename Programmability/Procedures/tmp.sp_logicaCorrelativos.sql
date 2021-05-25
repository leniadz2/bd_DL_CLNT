SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [tmp].[sp_logicaCorrelativos]
AS
BEGIN

  DECLARE @strgfini NVARCHAR(8);
  DECLARE @strgffin NVARCHAR(8);
  DECLARE @datefini DATE;
  DECLARE @dateffin DATE;

  SET DATEFIRST 1;

  SET @strgfini = '20210501';
  SET @strgffin = '20210502';

  SET @datefini = CONVERT(DATE, CONCAT(SUBSTRING(@strgfini, 1, 4), '-', SUBSTRING(@strgfini, 5, 2), '-', SUBSTRING(@strgfini, 7, 2)));
  SET @dateffin = CONVERT(DATE, CONCAT(SUBSTRING(@strgffin, 1, 4), '-', SUBSTRING(@strgffin, 5, 2), '-', SUBSTRING(@strgffin, 7, 2)));

--esta apuntando a SRV del stage, validar si apuntar el BDS

  DROP TABLE tmp.t_SRV_valCorrel_1;
  DROP TABLE tmp.t_SRV_valCorrel_2;
  DROP TABLE tmp.t_SRV_valCorrel_3;
  
  SELECT ts.CODIGOMALL,
         ts.RUCEMISOR, 
         ts.SERIE, 
         MIN(ts.NUMEROTRANSACCION*1) AS minCorrel,
         MAX(ts.NUMEROTRANSACCION*1) AS maxCorrel,
         MAX(ts.NUMEROTRANSACCION*1)*1 - MIN(ts.NUMEROTRANSACCION)*1 + 1 AS CantEsperadaDocs
         --,COUNT(NUMEROTRANSACCION) AS CantRealDocs
    INTO tmp.t_SRV_valCorrel_1
    FROM stg.SRV_TABLON ts
   GROUP BY ts.CODIGOMALL,
            ts.RUCEMISOR, 
            ts.SERIE
   ORDER BY 1,2,3,4,5;
  
  
  SELECT distinct ts.CODIGOMALL,
         ts.RUCEMISOR, 
         ts.SERIE
    INTO tmp.t_SRV_valCorrel_2
    FROM stg.SRV_TABLON ts;
  
  
  SELECT ts.CODIGOMALL,
         ts.RUCEMISOR, 
         ts.SERIE, 
         COUNT(NUMEROTRANSACCION) AS CantRealDocs
    INTO tmp.t_SRV_valCorrel_3
    FROM stg.SRV_TABLON ts
   GROUP BY ts.CODIGOMALL,
            ts.RUCEMISOR, 
            ts.SERIE
  ORDER BY 1,2,3;

END
GO