CREATE TABLE [stg].[PORTAL_REPORTE] (
  [CENTRO_COMERCIAL] [nvarchar](50) NULL,
  [MONEDA] [nvarchar](10) NULL,
  [FECHAINICIO] [datetime] NULL,
  [FECHAFIN] [datetime] NULL,
  [CONTRATO] [nvarchar](20) NULL,
  [RUC] [nvarchar](11) NULL,
  [RAZON_SOCIAL] [nvarchar](50) NULL,
  [NOMBRE_COMERCIAL] [nvarchar](50) NULL,
  [UNIDAD_ECONOMICA] [nvarchar](20) NULL,
  [LOCALES] [nvarchar](100) NULL,
  [DIA] [nvarchar](2) NULL,
  [MONTO] [float] NULL,
  [TRX] [float] NULL
)
ON [PRIMARY]
GO