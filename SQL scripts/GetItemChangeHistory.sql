USE [DevSitecore_Custom]
GO

/****** Object:  StoredProcedure [dbo].[GetItemChangeHistory]    Script Date: 2/1/2015 11:07:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetItemChangeHistory]
@ChangeId int = null,
@ApprovalStatus varchar(10) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



	SELECT [ItemID]
		  ,[FieldName]
		  ,DisplayFieldName = replace(replace(FieldName,'_x',''),'_','')
		  ,[OldValue]
		  ,[NewValue]
		  ,[ChangeType]
		  ,[ChangeDate]
		  ,[ItemHtml]
		  ,[Revision]
		  ,ProductName
		  ,h.ItemChangeId
	FROM [dbo].[ItemChangeHistory] h 
	INNER JOIN [dbo].[ItemChangeDetails] d ON h.ItemChangeId = d.ItemChangeId
	WHERE 
		(@ChangeId is null or h.ItemChangeId = @ChangeId) AND
		((@ApprovalStatus is not null and ApprovalStatus = @ApprovalStatus) or ApprovalStatus is null)
	ORDER BY ProductName, ChangeDate



END

GO


