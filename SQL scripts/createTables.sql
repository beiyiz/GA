USE [DevSitecore_Custom]
GO

/****** Object:  Table [dbo].[ItemChangeHistory]    Script Date: 2/1/2015 2:32:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

drop TABLE [dbo].[ItemChangeDetails]
go
drop table [dbo].[ItemChangeHistory]
go
CREATE TABLE [dbo].[ItemChangeHistory](
	[ItemChangeId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [varchar](50) NOT NULL,
	[Revision] [varchar](50)  NULL,	
	[ChangeType] [varchar](50) NOT NULL,
	[ChangeDate] [smalldatetime] NOT NULL,
	[ItemHtml] [varchar](max)   NULL,
	[ProductName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemChangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

alter table [dbo].[ItemChangeHistory] add  ApprovalStatus varchar(10) null
go

CREATE TABLE [dbo].[ItemChangeDetails](
	[ItemChangeDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ItemChangeId] [int] NOT NULL,
	[FieldName] [varchar](255) NOT NULL,
	[OldValue] [varchar](1000) NULL,
	[NewValue] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemChangeDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[ItemChangeDetails]
ADD FOREIGN KEY ([ItemChangeId])
REFERENCES [dbo].[ItemChangeHistory]([ItemChangeId])

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ItemChangeHistory] ADD  CONSTRAINT [DF_ItemChangeHistory_ChangeDate]  DEFAULT (getdate()) FOR [ChangeDate]
GO


