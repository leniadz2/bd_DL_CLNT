CREATE TABLE [stg].[ICG_ARTICULOS] (
  [COD_EMPRESA] [int] NOT NULL,
  [COD_DPTO] [int] NULL,
  [COD_SECCION] [smallint] NULL,
  [COD_FAMILIA] [smallint] NULL,
  [COD_SUBFAMILIA] [smallint] NULL,
  [COD_MARCA] [int] NULL,
  [COD_LINEA] [smallint] NULL,
  [CODARTICULO] [int] NOT NULL,
  [REFPROVEEDOR] [nvarchar](15) NULL,
  [DESCRIPCION] [nvarchar](40) NULL,
  [DESCRIPADIC] [nvarchar](25) NULL,
  [TIPOIMPUESTO] [int] NULL,
  [FORMULA] [nchar](1) NULL,
  [MANEJA_INVENTARIO] [nchar](1) NULL,
  [UNIDADMEDIDA] [nvarchar](10) NULL,
  [FECHAMODIFICADO] [datetime] NULL,
  [TIPOARTICULO] [nvarchar](1) NULL,
  [DESCATALOGADO] [nchar](1) NULL,
  [ULTIMO_COSTO] [int] NOT NULL,
  [COSTO_PROMEDIO] [int] NOT NULL
)
ON [PRIMARY]
GO