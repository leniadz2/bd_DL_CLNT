CREATE TABLE [tmp].[ICG_TABLON] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_CLIENTE] [int] NOT NULL,
  [NOMBRECOMERCIAL] [nvarchar](255) NULL,
  [CIF] [nvarchar](12) NULL,
  [CE] [nvarchar](12) NULL,
  [DNI] [nvarchar](12) NULL,
  [RUC] [nvarchar](12) NULL,
  [CIFTIPO] [varchar](3) NULL,
  [NOMBRECLIENTE] [nvarchar](255) NULL,
  [DIRECCION1] [nvarchar](255) NULL,
  [POBLACION] [nvarchar](100) NULL,
  [PROVINCIA] [nvarchar](100) NULL,
  [PAIS] [nvarchar](100) NULL,
  [CODPOSTAL] [nvarchar](8) NULL,
  [TELEFONO1] [nvarchar](15) NULL,
  [TELEFONO2] [nvarchar](15) NULL,
  [E_MAIL] [nvarchar](255) NULL,
  [ALIAS] [nvarchar](255) NULL,
  [PERSONACONTACTO] [nvarchar](255) NULL,
  [CODCONTABLE] [nvarchar](12) NULL,
  [FECHA] [varchar](8) NULL,
  [NEGOCIO] [nvarchar](50) NULL,
  [NOM_TIENDA] [nvarchar](50) NULL,
  [UBICACION] [nvarchar](50) NULL,
  [centro] [nvarchar](4) NOT NULL,
  [numserie] [nvarchar](4) NOT NULL,
  [NUMCORRELATIVO] [int] NOT NULL,
  [CODARTICULO] [int] NULL,
  [DESCRIPCION] [nvarchar](40) NULL,
  [UNIDADESTOTAL] [float] NULL,
  [TOTAL_L] [float] NOT NULL,
  [BASE] [float] NULL,
  [IMPUESTO] [float] NULL,
  [TOTAL] [float] NULL
)
ON [PRIMARY]
GO

CREATE INDEX [idx_ICG_TABLON]
  ON [tmp].[ICG_TABLON] ([numserie], [NUMCORRELATIVO])
  ON [PRIMARY]
GO