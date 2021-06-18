SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [bds].[SRVCOM_OPERADORES]
AS
/* toma los registros del SRV y les agrega data del RE como el gafo
*/
SELECT
  so.*
 ,cc.DFKKBPTAXNUM_NIF
 ,cc.VICNCN_sociedad
 ,cc.VICNCN_contrato
 ,cc.VICNCN_clvBienInmb
 ,cc.VICNCN_denominacionContrato
 ,co.Contrato
 ,co.InicioContrato
 ,co.FinContrato
 ,co.VigenciaContrato
 ,co.NombreComercial
 ,co.ObjetoAlquiler
 ,co.Gafo
 ,co.SubGafo
FROM BD_SRV.tmp.operadoresSRV so
LEFT JOIN bds.COM_CONTRATOS cc
  ON so.RUCEMISOR = cc.DFKKBPTAXNUM_NIF
    AND so.CONTRATO_RE = cc.VICNCN_contrato
    AND IIF(so.CODIGOMALL = '01', '3001', IIF(so.CODIGOMALL = '02', '4007', IIF(so.CODIGOMALL = '03', '3001', NULL))) = cc.VICNCN_sociedad
LEFT JOIN stg.COM_OPERADORES co
  ON CONCAT(cc.VICNCN_sociedad, 'CC - 000', cc.VICNCN_contrato) = co.Contrato
    AND CONCAT(SUBSTRING(so.fecha, 1, 4), SUBSTRING(so.fecha, 6, 2)) = co.Periodo
WHERE cc.VIBPOBJREL_ordInterloccomercial = 1;
GO